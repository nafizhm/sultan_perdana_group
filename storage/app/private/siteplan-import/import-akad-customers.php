<?php
// Approved scope: customers, marketing and dated akad only; no financial entries.
require getcwd().'/vendor/autoload.php';
Dotenv\Dotenv::createImmutable(getcwd())->safeLoad();
$config = file_exists('bootstrap/cache/config.php') ? require 'bootstrap/cache/config.php' : [];
$driver = $config['database']['default'] ?? ($_ENV['DB_CONNECTION'] ?? 'mysql');
$db = $config['database']['connections'][$driver] ?? [];
$pdo = new PDO('mysql:host='.($db['host'] ?? $_ENV['DB_HOST']).';port='.($db['port'] ?? $_ENV['DB_PORT'] ?? 3306).';dbname='.($db['database'] ?? $_ENV['DB_DATABASE']).';charset=utf8mb4', $db['username'] ?? $_ENV['DB_USERNAME'], $db['password'] ?? $_ENV['DB_PASSWORD'] ?? '', [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$source = 'D:/Downloads/Telegram Desktop/DATA AKAP KPR DAN CASH.xlsx';
$reportPath = __DIR__.'/akad-customer-import-report.json';
if (file_exists($reportPath)) throw new RuntimeException('Import report already exists; refusing duplicate import');
$book = PhpOffice\PhpSpreadsheet\IOFactory::load($source);
$rows = [];
$seen = [];
$months = ['JANUARI'=>1,'FEBRUARI'=>2,'MARET'=>3,'APRIL'=>4,'MEI'=>5,'JUNI'=>6,'JULI'=>7,'AGUSTUS'=>8,'SEPTEMBER'=>9,'OKTOBER'=>10,'NOVEMBER'=>11,'DESEMBER'=>12];
foreach ($book->getAllSheets() as $index=>$sheet) {
    foreach ($sheet->getRowIterator($index===0 ? 5 : 4) as $row) {
        $line = $row->getRowIndex();
        $name = trim((string)$sheet->getCell('B'.$line)->getValue());
        if ($name==='') continue;
        $codeRaw = trim((string)$sheet->getCell('C'.$line)->getValue());
        if (!preg_match('/^([A-Z]+)\s*(?:NO\.?\s*)?0*(\d+)$/i', $codeRaw, $match)) throw new RuntimeException('Invalid unit '.$codeRaw);
        $code = strtoupper($match[1]).'-'.str_pad($match[2],2,'0',STR_PAD_LEFT);
        if (isset($seen[$code])) throw new RuntimeException('Duplicate unit '.$code);
        $seen[$code] = true;
        $rawDate = $sheet->getCell(($index===0?'G':'I').$line)->getValue();
        $date = null;
        if (is_numeric($rawDate)) $date = PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($rawDate)->format('Y-m-d');
        elseif (trim((string)$rawDate)!=='') {
            if (!preg_match('/^(\d{1,2})\s+([A-Z]+)\s+(\d{4})$/', strtoupper(trim($rawDate)), $m) || !isset($months[$m[2]]) || !checkdate($months[$m[2]], (int)$m[1], (int)$m[3])) throw new RuntimeException('Invalid date '.$rawDate);
            $date = sprintf('%04d-%02d-%02d', $m[3], $months[$m[2]], $m[1]);
        }
        $original = [];
        foreach (range('A', $index===0?'I':'K') as $col) $original[$col] = $sheet->getCell($col.$line)->getCalculatedValue();
        $rows[] = ['sheet'=>$sheet->getTitle(),'row'=>$line,'name'=>$name,'code'=>$code,'date'=>$date,'marketing'=>trim((string)$sheet->getCell(($index===0?'I':'K').$line)->getValue()),'purchase'=>$index===0?'KPR':((int)$sheet->getCell('F'.$line)->getCalculatedValue()===0?'Pembelian Cash':'Cash Bertahap'),'source_values'=>$original];
    }
}
if (count($rows)!==81) throw new RuntimeException('Expected 81 customers');
$insert = function (string $table, array $values) use ($pdo): int {
    $columns = array_keys($values);
    $query = 'INSERT INTO `'.$table.'` (`'.implode('`,`', $columns).'`) VALUES ('.implode(',', array_fill(0,count($columns),'?')).')';
    $pdo->prepare($query)->execute(array_values($values));
    return (int)$pdo->lastInsertId();
};
$pdo->beginTransaction();
try {
    $loc = $pdo->query("SELECT id FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View'")->fetchColumn();
    if (!$loc) throw new RuntimeException('Location missing');
    $backup = [];
    foreach (['customer','marketing_offline','akad','detail_akad','persyaratan_legal','kavling_peta'] as $table) $backup[$table] = $pdo->query('SELECT * FROM `'.$table.'` FOR UPDATE')->fetchAll(PDO::FETCH_ASSOC);
    foreach (['customer','marketing_offline','akad','detail_akad'] as $table) if (count($backup[$table])!==0) throw new RuntimeException('Expected empty '.$table.'; refusing to overwrite existing data');
    $lots = [];
    foreach ($backup['kavling_peta'] as $lot) if ((int)$lot['id_lokasi']===(int)$loc) {
        if (isset($lots[$lot['kode_kavling']])) throw new RuntimeException('Ambiguous code');
        $lots[$lot['kode_kavling']] = $lot;
    }
    if (count(array_filter($lots, fn($lot)=>$lot['blok']==='I'))!==24) throw new RuntimeException('Block I correction missing');
    foreach ($rows as $row) {
        if (!isset($lots[$row['code']])) throw new RuntimeException('Missing unit '.$row['code']);
        if (!empty($lots[$row['code']]['id_customer'])) throw new RuntimeException('Occupied unit '.$row['code']);
        if ($row['marketing']==='') throw new RuntimeException('Missing marketing');
    }
    $backupPath = __DIR__.'/before-customer-import-'.date('Ymd-His').'.json';
    if (file_put_contents($backupPath,json_encode($backup,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT))===false) throw new RuntimeException('Backup failed');
    $marketing = [];
    $akad = [];
    $details = 0;
    foreach ($rows as $i=>&$row) {
        if (!isset($marketing[$row['marketing']])) {
            // Zero denotes unavailable gender; no personal or bank details are fabricated.
            $marketing[$row['marketing']] = $insert('marketing_offline', ['kode_marketing'=>'M-'.str_pad(count($marketing)+1,4,'0',STR_PAD_LEFT),'nama_marketing'=>$row['marketing'],'jenis_kelamin'=>0,'pekerjaan'=>'','nama_bank'=>'','no_rekening'=>'','atas_nama'=>'','status'=>1,'foto'=>'']);
        }
        $row['marketing_id'] = $marketing[$row['marketing']];
        $row['unit_id'] = (int)$lots[$row['code']]['id'];
        $row['customer_id'] = $insert('customer', ['kode_customer'=>'GDI-'.str_pad($i+1,4,'0',STR_PAD_LEFT),'id_lokasi'=>$loc,'id_kavling'=>$row['unit_id'],'id_status_progres'=>$row['purchase']==='KPR'?3:8,'nama_lengkap'=>$row['name'],'id_marketing'=>$row['marketing_id'],'jenis_pembelian'=>$row['purchase'],'termin_x_cash_b'=>null,'stt_arsip'=>0]);
        $legal = $insert('persyaratan_legal', ['id_customer'=>$row['customer_id'],'catatan_kekurangan'=>'Impor DATA AKAP KPR DAN CASH.xlsx, '.$row['sheet'].' baris '.$row['row'].'. Identitas customer belum tersedia. Berkas legal belum diverifikasi.']);
        $pdo->prepare('UPDATE kavling_peta SET id_customer=? WHERE id=?')->execute([$row['customer_id'],$row['unit_id']]);
        if ($row['date']) {
            if (!isset($akad[$row['date']])) $akad[$row['date']] = $insert('akad', ['tgl_akad'=>$row['date'],'keterangan'=>'Impor akad historis DATA AKAP KPR DAN CASH.xlsx; jenis dokumen belum tersedia']);
            $row['akad_detail_id'] = $insert('detail_akad', ['id_akad'=>$akad[$row['date']],'id_customer'=>$row['customer_id'],'id_persyaratan'=>$legal,'status'=>2,'jenis_akad'=>'','keterangan'=>'Sumber '.$row['sheet'].' baris '.$row['row'].'. AJB/PPJB belum diketahui. Keuangan belum diimpor.']);
            $details++;
        }
    }
    unset($row);
    $counts = [];
    foreach (['customer','marketing_offline','detail_akad','akad','persyaratan_legal'] as $table) $counts[$table] = (int)$pdo->query('SELECT COUNT(*) FROM `'.$table.'`')->fetchColumn();
    if ($counts['customer']!==81 || $counts['detail_akad']!==53 || $counts['persyaratan_legal']!==81) throw new RuntimeException('Unexpected imported counts');
    $report = ['source'=>$source,'sha256'=>hash_file('sha256',$source),'scope'=>'Customer, marketing dan akad; seluruh nominal dan transaksi keuangan ditunda','backup'=>$backupPath,'counts'=>$counts,'purchase_counts'=>array_count_values(array_column($rows,'purchase')),'rows'=>$rows];
    // Prepare report before commit; only the final filename marks a committed import.
    if (file_put_contents($reportPath.'.pending',json_encode($report,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE))===false) throw new RuntimeException('Report failed');
    $pdo->commit();
    if (!rename($reportPath.'.pending',$reportPath)) throw new RuntimeException('Committed; pending report could not be renamed');
    echo json_encode(['counts'=>$counts,'purchase_counts'=>$report['purchase_counts'],'report'=>$reportPath],JSON_PRETTY_PRINT).PHP_EOL;
} catch (Throwable $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    throw $e;
}
