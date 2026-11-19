<?php
require getcwd().'/vendor/autoload.php';$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
foreach(['wawancara','wawancara_sp3k','pengajuan_hold'] as $t){echo $t.PHP_EOL;foreach(Illuminate\Support\Facades\DB::select('SHOW COLUMNS FROM '.$t) as $c)echo "$c->Field $c->Type null=$c->Null default=$c->Default\n";}
foreach(['bank_kpr','status_progres'] as $t)echo $t.' '.json_encode(Illuminate\Support\Facades\DB::table($t)->get()).PHP_EOL;
