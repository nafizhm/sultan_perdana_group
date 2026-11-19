<?php
// One-off, guarded correction of the right-hand block in Kedamaian Sky View.
require getcwd().'/vendor/autoload.php';
Dotenv\Dotenv::createImmutable(getcwd())->safeLoad();
$config = file_exists('bootstrap/cache/config.php') ? require 'bootstrap/cache/config.php' : [];
$driver = $config['database']['default'] ?? ($_ENV['DB_CONNECTION'] ?? 'mysql');
$db = $config['database']['connections'][$driver] ?? [];
$pdo = new PDO('mysql:host='.($db['host'] ?? $_ENV['DB_HOST']).';port='.($db['port'] ?? $_ENV['DB_PORT'] ?? 3306).';dbname='.($db['database'] ?? $_ENV['DB_DATABASE']).';charset=utf8mb4', $db['username'] ?? $_ENV['DB_USERNAME'], $db['password'] ?? $_ENV['DB_PASSWORD'] ?? '', [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$pdo->beginTransaction();
try {
    $location = $pdo->query("SELECT id FROM lokasi_kavling WHERE nama_kavling='Kedamaian Sky View'")->fetchColumn();
    if (!$location) throw new RuntimeException('Location missing');
    $lots = $pdo->query("SELECT * FROM kavling_peta WHERE id_lokasi=$location AND kode_kavling REGEXP '^H-[0-9]{2}-2$' ORDER BY id FOR UPDATE")->fetchAll(PDO::FETCH_ASSOC);
    if (count($lots) !== 24) throw new RuntimeException('Expected exactly 24 right-hand lots; aborting');
    if ($pdo->query("SELECT COUNT(*) FROM kavling_peta WHERE id_lokasi=$location AND blok='I'")->fetchColumn()) throw new RuntimeException('Block I already exists');
    $master = $pdo->query("SELECT * FROM master_svg WHERE id_lokasi=$location FOR UPDATE")->fetch(PDO::FETCH_ASSOC);
    $count = 0;
    $footer = preg_replace_callback('~(<g transform="matrix\(([^)]+)\)"><text[^>]*>)H-(\d{2})(</text>)~', function ($m) use (&$count) {
        $matrix = preg_split('/[\s,]+/', trim($m[2]));
        if (count($matrix) !== 6 || (float)$matrix[4] < 7500) return $m[0];
        $count++;
        return $m[1].'I-'.$m[3].$m[4];
    }, $master['footer_svg']);
    if ($count !== 24) throw new RuntimeException('Expected exactly 24 right-hand labels, got '.$count);
    $doc = new DOMDocument();
    if (!$doc->loadXML(str_replace(['[[lebar]]','[[tinggi]]'], ['100%','100%'], $master['header_svg']).$footer, LIBXML_NONET)) throw new RuntimeException('SVG invalid');
    $backupPath = __DIR__.'/before-block-i-'.date('Ymd-His').'.json';
    if (file_put_contents($backupPath, json_encode(['lots'=>$lots, 'master_svg'=>$master], JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT)) === false) throw new RuntimeException('Backup failed');
    $update = $pdo->prepare('UPDATE kavling_peta SET blok=?, kode_kavling=?, keterangan=? WHERE id=? AND kode_kavling=?');
    foreach ($lots as $lot) {
        $new = 'I-'.$lot['no'];
        $update->execute(['I', $new, $lot['keterangan'].'; Koreksi blok kanan menjadi '.$new.' sesuai instruksi pengguna 2026-11-12', $lot['id'], $lot['kode_kavling']]);
        if ($update->rowCount() !== 1) throw new RuntimeException('Lot changed concurrently');
    }
    $pdo->prepare('UPDATE master_svg SET footer_svg=? WHERE id=?')->execute([$footer, $master['id']]);
    $duplicates = $pdo->query("SELECT kode_kavling FROM kavling_peta WHERE id_lokasi=$location GROUP BY kode_kavling HAVING COUNT(*)>1")->fetchAll();
    if ($duplicates) throw new RuntimeException('Duplicate codes');
    $pdo->commit();
    echo json_encode(['updated_lots'=>24, 'updated_labels'=>$count, 'backup'=>$backupPath, 'svg_valid'=>true], JSON_PRETTY_PRINT).PHP_EOL;
} catch (Throwable $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    throw $e;
}
