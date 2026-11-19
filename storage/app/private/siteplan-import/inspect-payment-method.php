<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
echo json_encode(Illuminate\Support\Facades\DB::select('SHOW COLUMNS FROM metode_bayar'),JSON_PRETTY_PRINT).PHP_EOL;
