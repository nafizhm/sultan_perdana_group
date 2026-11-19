<?php
require getcwd().'/vendor/autoload.php';Dotenv\Dotenv::createImmutable(getcwd())->safeLoad();
$pdo=new PDO('mysql:host='.$_ENV['DB_HOST'].';port='.($_ENV['DB_PORT']??3306).';charset=utf8mb4',$_ENV['DB_USERNAME'],$_ENV['DB_PASSWORD'],[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$source=$_ENV['DB_DATABASE'];$scratch='spl_not2_check_'.bin2hex(random_bytes(5));
$pdo->exec("CREATE DATABASE `$scratch` CHARACTER SET utf8mb4");
try{
 $tables=['lokasi_kavling','master_svg','kavling_peta','customer','pengajuan_hold','persyaratan_legal','wawancara','wawancara_sp3k','bank_kpr','progres_list_penjualan'];
 foreach($tables as $t)$pdo->exec("CREATE TABLE `$scratch`.`$t` LIKE `$source`.`$t`");$pdo->exec("USE `$scratch`");
 $backup=json_decode(file_get_contents(__DIR__.'/before-not2-20261120-045715.json'),true);$k=json_decode(file_get_contents(__DIR__.'/before-k10-20261119-192259.json'),true);
 foreach($tables as $t){
  $rows=$backup[$t]??$pdo->query("SELECT * FROM `$source`.`$t`")->fetchAll(PDO::FETCH_ASSOC);
  foreach($rows as $r){
   if($t==='master_svg'&&$r['id']==$k['master_svg']['id'])$r=$k['master_svg'];
   if($t==='kavling_peta'&&$r['id']==$k['lot']['id'])$r=$k['lot'];
   if(in_array($t,['lokasi_kavling','kavling_peta']))$r['id']+=2000;
   if(isset($r['id_lokasi']))$r['id_lokasi']+=2000;
   if(isset($r['id_kavling']))$r['id_kavling']+=2000;
   $pdo->prepare('INSERT INTO `'.$t.'` (`'.implode('`,`',array_keys($r)).'`) VALUES ('.implode(',',array_fill(0,count($r),'?')).')')->execute(array_values($r));
  }
 }
 foreach(['customer','pengajuan_hold','wawancara','wawancara_sp3k','bank_kpr'] as $t)$pdo->exec("ALTER TABLE `$t` AUTO_INCREMENT=9000");
 $sql=file_get_contents(getcwd().'/database/sql/2026_11_20_booking_sp3k_k10_hosting.sql');
 $start=strpos($sql,'CREATE PROCEDURE');$end=strpos($sql,'END$$',$start)+3;$pdo->exec(substr($sql,$start,$end-$start));
 $call=function()use($pdo){$s=$pdo->query('CALL spl_import_not2_20261120()');do{$s->fetchAll();}while($s->nextRowset());};
 $call();$counts=[];foreach($tables as $t)$counts[$t]=(int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn();
 if($counts['pengajuan_hold']!==83||$counts['customer']!==164||$counts['wawancara_sp3k']!==18)throw new Exception('Counts mismatch');
 if((int)$pdo->query("SELECT COUNT(*) FROM customer WHERE kode_customer LIKE 'IMP-KSV-NOT2-%' AND id_lokasi=2010 AND id>=9000")->fetchColumn()!==83)throw new Exception('Hosting ID remap failed');
 if((int)$pdo->query("SELECT COUNT(*) FROM pengajuan_hold WHERE no_registrasi IN ('IMP-KSV-NOT2-H-10','IMP-KSV-NOT2-L-09')")->fetchColumn())throw new Exception('Skipped unit imported');
 $call();foreach($counts as $t=>$n)if((int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn()!==$n)throw new Exception('Duplicate on rerun');
 $pdo->exec("UPDATE pengajuan_hold SET nama_lengkap='Conflict test' WHERE no_registrasi='IMP-KSV-NOT2-A-01'");
 $pdo->exec("UPDATE kavling_peta SET kode_kavling='K-09-2',no='09' WHERE kode_kavling='K-10' AND id_lokasi=2010");
 $pdo->prepare('UPDATE master_svg SET footer_svg=? WHERE id_lokasi=2010')->execute([$k['master_svg']['footer_svg']]);
 $rejected=false;try{$call();}catch(PDOException $e){if(str_contains($e->getMessage(),'Booking existing A-01 berbeda'))$rejected=true;else throw $e;}
 if(!$rejected||(int)$pdo->query("SELECT COUNT(*) FROM kavling_peta WHERE kode_kavling='K-09-2' AND id_lokasi=2010")->fetchColumn()!==1)throw new Exception('Rollback failed');
 echo json_encode(['bookings'=>83,'customers_added'=>83,'sp3k'=>18,'different_hosting_ids'=>'passed','rerun_no_duplicates'=>'passed','conflict_rollback'=>'passed'],JSON_PRETTY_PRINT).PHP_EOL;
}finally{if($pdo->inTransaction())$pdo->rollBack();$pdo->exec("DROP DATABASE `$scratch`");}
