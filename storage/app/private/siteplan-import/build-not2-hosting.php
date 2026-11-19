<?php
require getcwd().'/vendor/autoload.php';$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$report=json_decode(file_get_contents(__DIR__.'/not2-import-report.json'),true,512,JSON_THROW_ON_ERROR);
$q=fn($v)=>$v===null?'NULL':"CONVERT(X'".bin2hex((string)$v)."' USING utf8mb4) COLLATE utf8mb4_unicode_ci";
$insert=function($table,$row,$overrides=[])use($q){foreach($overrides as $k=>$v)$row[$k]=null;$values=[];foreach($row as $k=>$v)$values[]=$overrides[$k]??$q($v);return 'INSERT INTO `'.$table.'` (`'.implode('`,`',array_keys($row)).'`) VALUES ('.implode(',',$values).');';};
$sql=<<<'SQL'
-- Update KSV NOT-2: 83 booking/customer, 18 SP3K, koreksi K-10, sembunyikan Hold.
-- Lewati H-10 dan L-09. C-10 Cash. NIK duplikat sesuai sumber.
-- Nominal booking Rp655.000.000. Tidak membuat jurnal pemasukan/piutang.
-- Backup database hosting terlebih dahulu. Import via phpMyAdmin pada database aplikasi.
-- Memerlukan CREATE ROUTINE. ID dicari dari kode unit, bukan ID database lokal.
-- ALTER TABLE bersifat permanen walaupun transaksi data dibatalkan.
SET NAMES utf8mb4;
ALTER TABLE wawancara_sp3k
 MODIFY tgl_terbit_sp3k DATE NULL,
 MODIFY no_sp3k VARCHAR(255) NULL,
 MODIFY acc_plafon INT NULL,
 MODIFY tenor INT NULL;
DELIMITER $$
CREATE PROCEDURE spl_import_not2_20261120()
BEGIN
 DECLARE v_loc INT;
 DECLARE v_unit INT;
 DECLARE v_customer INT;
 DECLARE v_booking INT;
 DECLARE v_bank INT;
 DECLARE v_wawancara INT;
 DECLARE v_status INT;
 DECLARE v_master INT;
 DECLARE v_footer LONGTEXT;
 DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
 START TRANSACTION;
 IF (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME IN ('lokasi_kavling','kavling_peta','master_svg','customer','pengajuan_hold','persyaratan_legal','wawancara','wawancara_sp3k','bank_kpr','progres_list_penjualan') AND ENGINE='InnoDB')<>10 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tabel wajib belum lengkap atau bukan InnoDB';
 END IF;
 IF (SELECT COUNT(*) FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View')<>1 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Lokasi KSV tidak ditemukan/duplikat';
 END IF;
 SELECT id INTO v_loc FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View' FOR UPDATE;
 IF (SELECT COUNT(*) FROM master_svg WHERE id_lokasi=v_loc)<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Master SVG tidak sesuai'; END IF;
 SELECT id,footer_svg INTO v_master,v_footer FROM master_svg WHERE id_lokasi=v_loc FOR UPDATE;
SQL;
$backup=json_decode(file_get_contents(__DIR__.'/before-k10-20261119-192259.json'),true);
$old='<g transform="matrix(0.99863 -0.052336 0.052336 0.99863 12658.8 -6570.11)"><text x="20000" y="12500" class="fil5 fnt0">K-09</text>';
$a=$q($old);$b=$q(str_replace('K-09','K-10',$old));
$sql.="\n IF LOCATE($a,v_footer)>0 THEN SET v_footer=REPLACE(v_footer,$a,$b); ELSEIF LOCATE($b,v_footer)=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Label K-10 perlu diperiksa'; END IF;\n";
$sql.=" IF (SELECT COUNT(*) FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling IN ('K-09-2','K-10'))<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Unit K-10 tidak ditemukan/konflik'; END IF;\n UPDATE kavling_peta SET kode_kavling='K-10',no='10' WHERE id_lokasi=v_loc AND kode_kavling='K-09-2';\n UPDATE master_svg SET footer_svg=v_footer WHERE id=v_master;\n";
foreach($report['rows'] as $r){
 $code=$q($r['code']);$reg=$q('IMP-KSV-NOT2-'.$r['code']);$name=$q($r['name']);$nik=$q($r['nik']);$purchase=$q($r['purchase']);$paid=$r['paid'];$price=$r['price'];
 $statusName=$q(DB::table('progres_list_penjualan')->where('id',$r['sp3k']?4:2)->sole()->status_progres);
 $sql.="\n -- {$r['code']}, sumber baris {$r['row']}\n IF (SELECT COUNT(*) FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling=$code)<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Unit {$r['code']} tidak ditemukan/duplikat'; END IF;\n SELECT id INTO v_unit FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling=$code FOR UPDATE;\n IF (SELECT COUNT(*) FROM progres_list_penjualan WHERE status_progres=$statusName)<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Master status tidak sesuai'; END IF;\n SET v_status=(SELECT id FROM progres_list_penjualan WHERE status_progres=$statusName);\n IF (SELECT COUNT(*) FROM pengajuan_hold WHERE no_registrasi=$reg)>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Registrasi duplikat'; END IF;\n SET v_booking=(SELECT id FROM pengajuan_hold WHERE no_registrasi=$reg LIMIT 1);\n IF v_booking IS NOT NULL THEN\n IF NOT EXISTS(SELECT 1 FROM pengajuan_hold WHERE id=v_booking AND id_lokasi=v_loc AND id_kavling=v_unit AND BINARY nama_lengkap=BINARY $name AND nik=$nik AND booking_fee=$paid AND total_harga=$price AND jenis_pembelian=$purchase AND stt_reg=2) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Booking existing {$r['code']} berbeda'; END IF;\n IF (SELECT COUNT(*) FROM customer WHERE kode_customer=$reg AND id_kavling=v_unit AND id_lokasi=v_loc AND BINARY nama_lengkap=BINARY $name AND nik=$nik AND jenis_pembelian=$purchase AND id_status_progres=v_status AND stt_arsip=0)<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Customer existing {$r['code']} berbeda'; END IF;\n ELSE\n IF EXISTS(SELECT 1 FROM customer WHERE kode_customer=$reg OR (id_kavling=v_unit AND stt_arsip=0)) OR EXISTS(SELECT 1 FROM pengajuan_hold WHERE id_kavling=v_unit AND stt_reg IN (1,2)) OR EXISTS(SELECT 1 FROM kavling_peta WHERE id=v_unit AND COALESCE(id_customer,0)<>0) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Unit {$r['code']} sudah digunakan; transaksi dibatalkan'; END IF;\n";
 $customer=(array)DB::table('customer')->where('id',$r['customer_id'])->sole();unset($customer['id']);
 $sql.=$insert('customer',$customer,['id_lokasi'=>'v_loc','id_kavling'=>'v_unit','id_status_progres'=>'v_status'])."\n SET v_customer=LAST_INSERT_ID();\n";
 $booking=(array)DB::table('pengajuan_hold')->where('id',$r['booking_id'])->sole();unset($booking['id']);
 $sql.=$insert('pengajuan_hold',$booking,['id_lokasi'=>'v_loc','id_kavling'=>'v_unit'])."\n";
 $legal=(array)DB::table('persyaratan_legal')->where('id_customer',$r['customer_id'])->sole();unset($legal['id']);
 $sql.=$insert('persyaratan_legal',$legal,['id_customer'=>'v_customer'])."\n UPDATE kavling_peta SET id_customer=v_customer,hrg_jual=$price WHERE id=v_unit;\n";
 if($r['sp3k']){
  $sp=(array)DB::table('wawancara_sp3k')->where('id',$r['sp3k_id'])->sole();$w=(array)DB::table('wawancara')->where('id',$sp['id_wawancara'])->sole();
  $sql.=" SET v_bank=0;\n";
  if($sp['id_bank_kpr']){$bank=$q(DB::table('bank_kpr')->where('id',$sp['id_bank_kpr'])->sole()->nama);$sql.=" IF (SELECT COUNT(*) FROM bank_kpr WHERE UPPER(TRIM(nama))=UPPER($bank))>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Master bank duplikat'; END IF;\n SET v_bank=(SELECT id FROM bank_kpr WHERE UPPER(TRIM(nama))=UPPER($bank) LIMIT 1);\n IF v_bank IS NULL THEN INSERT INTO bank_kpr(nama) VALUES($bank); SET v_bank=LAST_INSERT_ID(); END IF;\n";}
  unset($w['id'],$sp['id']);$sql.=$insert('wawancara',$w,['id_customer'=>'v_customer','id_bank_kpr'=>'v_bank'])."\n SET v_wawancara=LAST_INSERT_ID();\n".$insert('wawancara_sp3k',$sp,['id_wawancara'=>'v_wawancara','id_bank_kpr'=>'v_bank'])."\n";
 }
 $sql.=" END IF;\n";
}
$sql.=<<<'SQL'
 UPDATE progres_list_penjualan SET stt_tampil=0 WHERE LOWER(TRIM(status_progres))='hold';
 IF (SELECT COUNT(*) FROM pengajuan_hold WHERE no_registrasi LIKE 'IMP-KSV-NOT2-%')<>83 OR (SELECT SUM(booking_fee) FROM pengajuan_hold WHERE no_registrasi LIKE 'IMP-KSV-NOT2-%')<>655000000 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Verifikasi booking gagal'; END IF;
 IF (SELECT COUNT(*) FROM wawancara_sp3k s JOIN wawancara w ON w.id=s.id_wawancara JOIN customer c ON c.id=w.id_customer WHERE c.kode_customer LIKE 'IMP-KSV-NOT2-%' AND s.status=1)<>18 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Verifikasi SP3K gagal'; END IF;
 COMMIT;
 SELECT 'BERHASIL: 83 booking/customer, 18 SP3K, K-10 dikoreksi, Hold disembunyikan' AS hasil;
END$$
CALL spl_import_not2_20261120()$$
DROP PROCEDURE spl_import_not2_20261120$$
DELIMITER ;
SQL;
$path=getcwd().'/database/sql/2026_11_20_booking_sp3k_k10_hosting.sql';file_put_contents($path,$sql);echo $path.PHP_EOL;


