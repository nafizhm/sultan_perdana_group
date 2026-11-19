<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
foreach(['lokasi_kavling','bank','metode_bayar','kategori_transaksi','status_progres'] as $t){try{echo $t.' '.json_encode(DB::table($t)->get()).PHP_EOL;}catch(Throwable $e){echo $t.' '.$e->getMessage().PHP_EOL;}}
foreach(['pengajuan_hold','customer','pemasukan','piutang','kavling_peta','persyaratan_legal'] as $t){echo $t.' count='.DB::table($t)->count().PHP_EOL;echo json_encode(DB::select('SHOW COLUMNS FROM `'.$t.'`')).PHP_EOL;}
