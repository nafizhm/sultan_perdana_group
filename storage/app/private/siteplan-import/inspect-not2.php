<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$book=PhpOffice\PhpSpreadsheet\IOFactory::load('D:/Downloads/Telegram Desktop/DATA KONSUMEN KSV NOT-2.xlsx');
$rows=[];$niks=[];$names=[];$phones=[];$issues=[];
foreach($book->getActiveSheet()->toArray(null,false,true,true) as $i=>$r){
 if($i<4||!trim((string)$r['B']))continue;
 preg_match('/^([A-Z]+)\s+No\.\s*(\d+)$/i',$r['E'],$m);$code=isset($m[2])?$m[1].'-'.str_pad($m[2],2,'0',STR_PAD_LEFT):$r['E'];
 $item=['row'=>$i,'code'=>$code,'name'=>$r['B'],'nik'=>(string)$r['C'],'phone'=>(string)$r['D'],'price'=>$r['G'],'paid'=>$r['J'],'scheme'=>$r['H'],'note'=>$r['K']];$rows[]=$item;
 $label=$code.' '.$r['B'];$niks[(string)$r['C']][]=$label;$names[strtolower(trim($r['B']))][]=$label;$phones[(string)$r['D']][]=$label;
 $lots=DB::table('kavling_peta')->where('id_lokasi',10)->where('kode_kavling',$code)->get();
 if($lots->count()!==1)$issues[]=['unit'=>$label,'reason'=>'Kavling tidak ditemukan/ambigu'];
 else { $customers=DB::table('customer')->where('id_kavling',$lots[0]->id)->where('stt_arsip',0)->pluck('nama_lengkap');if($customers->count())$issues[]=['unit'=>$label,'existing'=>$customers]; }
}
$report=['count'=>count($rows),'total_paid'=>array_sum(array_map(fn($r)=>(int)preg_replace('/[^0-9]/','',$r['paid']),$rows)),'duplicate_niks'=>array_filter($niks,fn($v)=>count($v)>1),'duplicate_names'=>array_filter($names,fn($v)=>count($v)>1),'duplicate_phones'=>array_filter($phones,fn($v)=>count($v)>1),'issues'=>$issues,'rows'=>$rows];
file_put_contents(__DIR__.'/not2-preflight.json',json_encode($report,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE));unset($report['rows']);echo json_encode($report,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE).PHP_EOL;
$master=DB::table('master_svg')->where('id_lokasi',10)->sole();preg_match_all('~.{0,120}K-09.{0,100}~',$master->footer_svg,$matches);echo json_encode($matches[0]).PHP_EOL;

