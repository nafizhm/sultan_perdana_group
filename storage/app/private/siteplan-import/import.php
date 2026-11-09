<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$plans = json_decode(file_get_contents('storage/app/private/siteplan-import/prepared.json'), true, 512, JSON_THROW_ON_ERROR);
$backup=[];
foreach ($plans as $plan) {
    $location=DB::table('lokasi_kavling')->where('nama_kavling',$plan['name'])->first();
    if ($location) throw new RuntimeException('Location already exists: '.$plan['name']);
}
file_put_contents('storage/app/private/siteplan-import/before-import.json', json_encode(['locations'=>DB::table('lokasi_kavling')->get(),'master_svg'=>DB::table('master_svg')->get(),'kavling_peta'=>DB::table('kavling_peta')->get()],JSON_THROW_ON_ERROR));
DB::transaction(function () use ($plans) {
    foreach ($plans as $i=>$plan) {
        $id=DB::table('lokasi_kavling')->insertGetId(['nama_kavling'=>$plan['name'],'nama_singkat'=>$plan['short'],'alamat'=>'','urutan'=>(DB::table('lokasi_kavling')->max('urutan')??0)+1,'stt_tampil'=>1,'header'=>$plan['name'],'is_cluster'=>0,'no_kwitansi'=>'','no_bast'=>'','no_ppjb'=>'','reset_nomor'=>0]);
        DB::table('master_svg')->insert(['id_lokasi'=>$id,'header_xml'=>'<?xml version="1.0" encoding="UTF-8"?>','header_svg'=>$plan['header'],'footer_svg'=>$plan['footer'],'body_svg'=>'','polygon_svg'=>'<polygon points="[[1]]" fill="[[2]]" stroke="#555" stroke-width="12" transform="[[3]]"><title>[[4]]</title></polygon>','path_svg'=>'<path d="[[1]]" fill="[[2]]" stroke="#555" stroke-width="12" transform="[[3]]"><title>[[4]]</title></path>','lebar'=>$plan['width'],'tinggi'=>$plan['height'],'ukuran_dashboard'=>100]);
        foreach ($plan['lots'] as $lot) DB::table('kavling_peta')->insert(['id_lokasi'=>$id,'blok'=>$lot['blok'],'no'=>$lot['no'],'kode_kavling'=>$lot['code'],'jenis_map'=>$lot['kind'],'map'=>$lot['map'],'matrik'=>$lot['transform'],'keterangan'=>'Sumber SVG: '.$plan['name'].'; bidang '.$lot['source_id'].'; label asli '.$lot['label']]);
        echo $plan['name'].': lokasi '.$id.', '.count($plan['lots']).' bidang',PHP_EOL;
    }
});
foreach ($plans as $plan) {
    $location=App\Models\LokasiKavling::with('masterSvg','kavlingPeta')->where('nama_kavling',$plan['name'])->firstOrFail();
    $m=$location->masterSvg;
    $svg=str_replace(['[[lebar]]','[[tinggi]]'],['100%','100%'],$m->header_svg);
    foreach ($location->kavlingPeta as $lot) $svg.=str_replace(['[[1]]','[[2]]','[[3]]','[[4]]'],[$lot->map,'#ffffff',$lot->matrik,$lot->kode_kavling],$lot->jenis_map==='polygon'?$m->polygon_svg:$m->path_svg);
    $svg.=$m->footer_svg;
    $doc=new DOMDocument(); if (!$doc->loadXML($svg, LIBXML_NONET)) throw new RuntimeException('Invalid rendered SVG');
    if ($location->kavlingPeta->pluck('kode_kavling')->unique()->count()!==count($plan['lots'])) throw new RuntimeException('Duplicate code');
    file_put_contents('storage/app/private/siteplan-import/'.$plan['slug'].'-rendered.svg',$svg);
    echo 'Verified '.$plan['name'].': SVG valid, '.count($plan['lots']).' unique units',PHP_EOL;
}
