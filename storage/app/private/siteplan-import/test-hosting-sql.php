<?php
require getcwd().'/vendor/autoload.php';
Dotenv\Dotenv::createImmutable(getcwd())->safeLoad();
$pdo=new PDO('mysql:host='.$_ENV['DB_HOST'].';port='.($_ENV['DB_PORT']??3306).';charset=utf8mb4',$_ENV['DB_USERNAME'],$_ENV['DB_PASSWORD'],[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$source=$_ENV['DB_DATABASE'];
$scratch='spl_import_check_'.bin2hex(random_bytes(5));
if (!preg_match('/^spl_import_check_[a-f0-9]{10}$/',$scratch)) throw new Exception('Invalid scratch name');
$pdo->exec('CREATE DATABASE `'.$scratch.'` CHARACTER SET utf8mb4');
try {
    $tables=['lokasi_kavling','kavling_peta','master_svg','customer','marketing_offline','persyaratan_legal','akad','detail_akad','progres_list_penjualan'];
    foreach($tables as $t)$pdo->exec("CREATE TABLE `$scratch`.`$t` LIKE `$source`.`$t`");
    $pdo->exec("USE `$scratch`");
    $before=json_decode(file_get_contents(__DIR__.'/before-customer-import-20261112-073225.json'),true);
    $block=json_decode(file_get_contents(__DIR__.'/before-block-i-20261112-073106.json'),true);
    $oldLots=array_column($block['lots'],null,'id');
    $insert=function($t,$r)use($pdo){$cols=array_keys($r);$pdo->prepare('INSERT INTO `'.$t.'` (`'.implode('`,`',$cols).'`) VALUES ('.implode(',',array_fill(0,count($r),'?')).')')->execute(array_values($r));};
    foreach(['lokasi_kavling','master_svg','progres_list_penjualan'] as $t){foreach($pdo->query("SELECT * FROM `$source`.`$t`")->fetchAll(PDO::FETCH_ASSOC) as $r){if($t==='master_svg' && $r['id']===$block['master_svg']['id'])$r=$block['master_svg'];if($t==='lokasi_kavling')$r['id']+=2000;if($t==='master_svg')$r['id_lokasi']+=2000;$insert($t,$r);}}
    foreach($before['kavling_peta'] as $r){$r=$oldLots[$r['id']]??$r;$r['id']+=2000;$r['id_lokasi']+=2000;$insert('kavling_peta',$r);}
    foreach(['customer','marketing_offline','persyaratan_legal','akad','detail_akad'] as $t)$pdo->exec("ALTER TABLE `$t` AUTO_INCREMENT=3000");
    $sql=file_get_contents(getcwd().'/database/sql/2026_11_12_import_customer_akad_hosting.sql');
    $start=strpos($sql,'CREATE PROCEDURE');$end=strpos($sql,'END$$',$start)+3;$procedure=substr($sql,$start,$end-$start);
    $pdo->exec($procedure);
    $call=function()use($pdo){$s=$pdo->query('CALL spl_import_20261112_akad_v1()');$result=$s->fetchAll(PDO::FETCH_ASSOC);while($s->nextRowset()){}return $result;};
    $call();$counts=[];foreach(['customer'=>81,'marketing_offline'=>22,'detail_akad'=>53,'akad'=>28,'persyaratan_legal'=>81] as $t=>$expected){$counts[$t]=(int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn();if($counts[$t]!==$expected)throw new Exception('Count mismatch '.$t);}
    $report=json_decode(file_get_contents(__DIR__.'/akad-customer-import-report.json'),true);
    foreach($report['rows'] as $r){$s=$pdo->prepare('SELECT c.id,c.nama_lengkap,c.jenis_pembelian,k.kode_kavling,m.nama_marketing FROM customer c JOIN kavling_peta k ON k.id=c.id_kavling JOIN marketing_offline m ON m.id=c.id_marketing WHERE k.kode_kavling=? AND c.id_lokasi=2010');$s->execute([$r['code']]);$actual=$s->fetch(PDO::FETCH_ASSOC);if(!$actual||$actual['nama_lengkap']!==$r['name']||$actual['nama_marketing']!==$r['marketing']||$actual['jenis_pembelian']!==$r['purchase'])throw new Exception('Mismatch '.$r['code']);if($actual['id']<3000)throw new Exception('ID independence check failed');}
    $call();foreach($counts as $t=>$count)if((int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn()!==$count)throw new Exception('Duplicate on rerun');
    $pdo->exec("UPDATE customer SET nama_lengkap='Conflict test' WHERE kode_customer='GDI-0001'");
    foreach($block['lots'] as $lot)$pdo->prepare('UPDATE kavling_peta SET blok=?,kode_kavling=? WHERE id=?')->execute(['H',$lot['kode_kavling'],$lot['id']+2000]);
    $pdo->prepare('UPDATE master_svg SET footer_svg=? WHERE id_lokasi=2010')->execute([$block['master_svg']['footer_svg']]);
    $rejected=false;try{$call();}catch(PDOException $e){if(str_contains($e->getMessage(),'Customer existing C-12 berbeda'))$rejected=true;else throw $e;}
    if(!$rejected)throw new Exception('Conflict was not rejected');
    if((int)$pdo->query("SELECT COUNT(*) FROM kavling_peta WHERE blok='I'")->fetchColumn()!==0)throw new Exception('Correction was not rolled back');
    if($pdo->query('SELECT footer_svg FROM master_svg WHERE id_lokasi=2010')->fetchColumn()!==$block['master_svg']['footer_svg'])throw new Exception('SVG was not rolled back');
    echo json_encode(['counts'=>$counts,'different_hosting_ids'=>'passed','rerun_without_duplicates'=>'passed','conflict_rolls_back_entire_import'=>'passed'],JSON_PRETTY_PRINT).PHP_EOL;
} finally {
    if($pdo->inTransaction())$pdo->rollBack();
    $pdo->exec('DROP DATABASE `'.$scratch.'`');
}
