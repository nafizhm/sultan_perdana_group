<?php
$dir = __DIR__;
$report = json_decode(file_get_contents($dir.'/akad-customer-import-report.json'), true, 512, JSON_THROW_ON_ERROR);
$backup = json_decode(file_get_contents($dir.'/before-block-i-20261112-073106.json'), true, 512, JSON_THROW_ON_ERROR);
$quote = fn($v) => $v === null ? 'NULL' : "X'".bin2hex((string)$v)."'";
$sql = <<<'SQL'
-- Kedamaian Sky View: koreksi blok I dan impor customer/marketing/akad.
-- Sumber: DATA AKAP KPR DAN CASH.xlsx; 81 customer, 22 marketing, 53 detail akad.
-- TIDAK memasukkan nominal, pemasukan, pengeluaran, piutang, atau hutang.
-- Pilih database aplikasi di phpMyAdmin, backup database, lalu Import file ini.
-- Membutuhkan MySQL/MariaDB dengan izin CREATE ROUTINE; semua tabel harus InnoDB.
-- Konflik data membatalkan seluruh transaksi; data yang sudah sama dilewati.
SET NAMES utf8mb4;
DELIMITER $$
CREATE PROCEDURE spl_import_20261112_akad_v1()
BEGIN
    DECLARE v_loc INT;
    DECLARE v_unit INT;
    DECLARE v_customer INT;
    DECLARE v_marketing INT;
    DECLARE v_legal INT;
    DECLARE v_akad INT;
    DECLARE v_akad_status INT;
    DECLARE v_cash_status INT;
    DECLARE v_customer_seq INT DEFAULT 0;
    DECLARE v_marketing_seq INT DEFAULT 0;
    DECLARE v_master INT;
    DECLARE v_footer LONGTEXT;
    DECLARE v_count INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    IF (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE()
        AND TABLE_NAME IN ('lokasi_kavling','kavling_peta','master_svg','customer','marketing_offline','persyaratan_legal','akad','detail_akad','progres_list_penjualan') AND ENGINE='InnoDB') <> 9 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tabel wajib belum lengkap atau bukan InnoDB';
    END IF;
    IF (SELECT COUNT(*) FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Lokasi Kedamaian Sky View tidak ditemukan/duplikat';
    END IF;
    SELECT id INTO v_loc FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View' FOR UPDATE;
    IF (SELECT COUNT(*) FROM progres_list_penjualan WHERE status_progres='Akad') <> 1
        OR (SELECT COUNT(*) FROM progres_list_penjualan WHERE status_progres='Pembelian Cash') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Master status Akad/Pembelian Cash tidak sesuai';
    END IF;
    SELECT id INTO v_akad_status FROM progres_list_penjualan WHERE status_progres='Akad';
    SELECT id INTO v_cash_status FROM progres_list_penjualan WHERE status_progres='Pembelian Cash';
    IF (SELECT COUNT(*) FROM master_svg WHERE id_lokasi=v_loc) <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Master SVG lokasi tidak ditemukan/duplikat';
    END IF;
    SELECT id,footer_svg INTO v_master,v_footer FROM master_svg WHERE id_lokasi=v_loc FOR UPDATE;
SQL;
$sql .= "\n";
preg_match_all('~(<g transform="matrix\(([^)]+)\)"><text[^>]*>)H-(\d{2})(</text>)~', $backup['master_svg']['footer_svg'], $matches, PREG_SET_ORDER);
$labels = 0;
foreach ($matches as $m) {
    $matrix = preg_split('/[\s,]+/', trim($m[2]));
    if ((float)$matrix[4] < 7500) continue;
    $labels++;
    $old = $quote($m[0]);
    $new = $quote($m[1].'I-'.$m[3].$m[4]);
    $sql .= "    IF LOCATE($old,v_footer)>0 THEN\n        SET v_footer=REPLACE(v_footer,$old,$new);\n    ELSEIF LOCATE($new,v_footer)=0 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='SVG blok kanan berbeda; label I-{$m[3]} perlu diperiksa';\n    END IF;\n";
}
if ($labels !== 24) throw new RuntimeException('Expected 24 labels');
foreach ($backup['lots'] as $lot) {
    $old=$quote($lot['kode_kavling']);$new=$quote('I-'.$lot['no']);$no=$quote($lot['no']);
    $sql .= "    IF (SELECT COUNT(*) FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling IN ($old,$new))<>1 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Kavling I-{$lot['no']} tidak ditemukan atau konflik';\n    END IF;\n    UPDATE kavling_peta SET blok='I',no=$no,kode_kavling=$new WHERE id_lokasi=v_loc AND kode_kavling=$old;\n";
}
$sql .= <<<'SQL'
    UPDATE master_svg SET footer_svg=v_footer WHERE id=v_master;
    SELECT COALESCE(MAX(CAST(SUBSTRING(kode_customer,5) AS UNSIGNED)),0) INTO v_customer_seq
        FROM customer WHERE kode_customer REGEXP '^GDI-[0-9]+$';
    SELECT COALESCE(MAX(CAST(SUBSTRING(kode_marketing,3) AS UNSIGNED)),0) INTO v_marketing_seq
        FROM marketing_offline WHERE kode_marketing REGEXP '^M-[0-9]+$';
SQL;
foreach ($report['rows'] as $row) {
    $code=$quote($row['code']);$name=$quote($row['name']);$marketing=$quote($row['marketing']);$purchase=$quote($row['purchase']);$status=$row['purchase']==='KPR'?'v_akad_status':'v_cash_status';
    $note=$quote('Impor DATA AKAP KPR DAN CASH.xlsx, '.$row['sheet'].' baris '.$row['row'].'. Identitas customer belum tersedia. Berkas legal belum diverifikasi.');
    $sql .= "\n    -- {$row['sheet']}, baris {$row['row']}, {$row['code']}\n";
    $sql .= "    IF (SELECT COUNT(*) FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling=$code)<>1 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Unit {$row['code']} tidak ditemukan/duplikat';\n    END IF;\n    SELECT id INTO v_unit FROM kavling_peta WHERE id_lokasi=v_loc AND kode_kavling=$code FOR UPDATE;\n";
    $sql .= "    IF (SELECT COUNT(*) FROM marketing_offline WHERE BINARY nama_marketing=BINARY $marketing)>1 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Nama marketing duplikat; periksa master';\n    END IF;\n    SET v_marketing=(SELECT id FROM marketing_offline WHERE BINARY nama_marketing=BINARY $marketing LIMIT 1);\n    IF v_marketing IS NULL THEN\n        SET v_marketing_seq=v_marketing_seq+1;\n        INSERT INTO marketing_offline(kode_marketing,nama_marketing,jenis_kelamin,pekerjaan,nama_bank,no_rekening,atas_nama,status,foto)\n        VALUES(CONCAT('M-',LPAD(v_marketing_seq,GREATEST(4,LENGTH(v_marketing_seq)),'0')),$marketing,0,'','','','',1,'');\n        SET v_marketing=LAST_INSERT_ID();\n    END IF;\n";
    $sql .= "    IF (SELECT COUNT(*) FROM customer WHERE id_kavling=v_unit AND (stt_arsip=0 OR stt_arsip IS NULL))>1 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Lebih dari satu customer aktif {$row['code']}';\n    END IF;\n    SET v_customer=(SELECT id FROM customer WHERE id_kavling=v_unit AND (stt_arsip=0 OR stt_arsip IS NULL) LIMIT 1);\n    IF v_customer IS NOT NULL THEN\n        IF NOT EXISTS(SELECT 1 FROM customer WHERE id=v_customer AND BINARY nama_lengkap=BINARY $name AND id_lokasi=v_loc AND jenis_pembelian=$purchase AND id_marketing=v_marketing AND id_status_progres=$status) THEN\n            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Customer existing {$row['code']} berbeda; impor dibatalkan';\n        END IF;\n    ELSE\n        SET v_customer_seq=v_customer_seq+1;\n        INSERT INTO customer(kode_customer,id_lokasi,id_kavling,id_status_progres,nama_lengkap,id_marketing,jenis_pembelian,termin_x_cash_b,stt_arsip)\n        VALUES(CONCAT('GDI-',LPAD(v_customer_seq,GREATEST(4,LENGTH(v_customer_seq)),'0')),v_loc,v_unit,$status,$name,v_marketing,$purchase,NULL,0);\n        SET v_customer=LAST_INSERT_ID();\n    END IF;\n    IF EXISTS(SELECT 1 FROM kavling_peta WHERE id=v_unit AND id_customer IS NOT NULL AND id_customer<>0 AND id_customer<>v_customer) THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Relasi customer kavling {$row['code']} berbeda';\n    END IF;\n    UPDATE kavling_peta SET id_customer=v_customer WHERE id=v_unit;\n    IF (SELECT COUNT(*) FROM persyaratan_legal WHERE id_customer=v_customer)>1 THEN\n        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Persyaratan legal duplikat';\n    END IF;\n    SET v_legal=(SELECT id FROM persyaratan_legal WHERE id_customer=v_customer LIMIT 1);\n    IF v_legal IS NULL THEN\n        INSERT INTO persyaratan_legal(id_customer,catatan_kekurangan) VALUES(v_customer,$note);\n        SET v_legal=LAST_INSERT_ID();\n    END IF;\n";
    if ($row['date']) {
        $date=$quote($row['date']);$desc=$quote('Impor akad historis DATA AKAP KPR DAN CASH.xlsx; jenis dokumen belum tersedia');$detail=$quote('Sumber '.$row['sheet'].' baris '.$row['row'].'. AJB/PPJB belum diketahui. Keuangan belum diimpor.');
        $sql .= "    SELECT COUNT(*) INTO v_count FROM detail_akad WHERE id_customer=v_customer;\n    IF v_count>0 THEN\n        IF v_count<>1 OR NOT EXISTS(SELECT 1 FROM detail_akad d JOIN akad a ON a.id=d.id_akad WHERE d.id_customer=v_customer AND d.status=2 AND a.tgl_akad=$date) THEN\n            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Akad existing {$row['code']} berbeda';\n        END IF;\n    ELSE\n        IF (SELECT COUNT(*) FROM akad WHERE tgl_akad=$date AND keterangan=$desc)>1 THEN\n            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Jadwal akad impor duplikat';\n        END IF;\n        SET v_akad=(SELECT id FROM akad WHERE tgl_akad=$date AND keterangan=$desc LIMIT 1);\n        IF v_akad IS NULL THEN\n            INSERT INTO akad(tgl_akad,keterangan) VALUES($date,$desc);\n            SET v_akad=LAST_INSERT_ID();\n        END IF;\n        INSERT INTO detail_akad(id_akad,id_customer,id_persyaratan,status,jenis_akad,keterangan) VALUES(v_akad,v_customer,v_legal,2,'',$detail);\n    END IF;\n";
    }
}
$sql .= <<<'SQL'

    COMMIT;
    SELECT 'BERHASIL: blok I, 81 customer dan 53 akad sudah diproses; keuangan tidak diimpor' AS hasil;
END$$
CALL spl_import_20261112_akad_v1()$$
DROP PROCEDURE spl_import_20261112_akad_v1$$
DELIMITER ;
SQL;
$path=getcwd().'/database/sql/2026_11_12_import_customer_akad_hosting.sql';
file_put_contents($path,$sql."\n");
echo $path.' ('.strlen($sql).' bytes)'.PHP_EOL;
