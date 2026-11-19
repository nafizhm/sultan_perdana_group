<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
DB::transaction(function(){
 $location=DB::table('lokasi_kavling')->where('nama_kavling','Kedamaian Sky View')->sole();
 $lot=DB::table('kavling_peta')->where('id_lokasi',$location->id)->where('kode_kavling','K-09-2')->lockForUpdate()->sole();
 if(DB::table('kavling_peta')->where('id_lokasi',$location->id)->where('kode_kavling','K-10')->exists())throw new RuntimeException('K-10 already exists');
 $master=DB::table('master_svg')->where('id_lokasi',$location->id)->lockForUpdate()->sole();
 $old='<g transform="matrix(0.99863 -0.052336 0.052336 0.99863 12658.8 -6570.11)"><text x="20000" y="12500" class="fil5 fnt0">K-09</text>';
 if(substr_count($master->footer_svg,$old)!==1)throw new RuntimeException('Unexpected label geometry');
 $footer=str_replace($old,str_replace('K-09','K-10',$old),$master->footer_svg);
 $doc=new DOMDocument();if(!$doc->loadXML(str_replace(['[[lebar]]','[[tinggi]]'],['100%','100%'],$master->header_svg).$footer,LIBXML_NONET))throw new RuntimeException('Invalid SVG');
 $backup=__DIR__.'/before-k10-'.date('Ymd-His').'.json';
 if(file_put_contents($backup,json_encode(['lot'=>$lot,'master_svg'=>$master],JSON_PRETTY_PRINT|JSON_THROW_ON_ERROR))===false)throw new RuntimeException('Backup failed');
 DB::table('kavling_peta')->where('id',$lot->id)->update(['kode_kavling'=>'K-10','no'=>'10','keterangan'=>$lot->keterangan.'; Koreksi menjadi K-10 sesuai instruksi pengguna 2026-11-19']);
 DB::table('master_svg')->where('id',$master->id)->update(['footer_svg'=>$footer]);
 if(substr_count($footer,'>K-09</text>')!==1||substr_count($footer,'>K-10</text>')!==1)throw new RuntimeException('Label verification failed');
 echo json_encode(['updated_unit'=>$lot->id,'code'=>'K-10','svg_valid'=>true,'backup'=>$backup]).PHP_EOL;
});
