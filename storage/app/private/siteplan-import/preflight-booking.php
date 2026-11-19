<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$sheet=PhpOffice\PhpSpreadsheet\IOFactory::load('D:/Downloads/Telegram Desktop/DATA KONSUMEN KSV NOT-1.xlsx')->getActiveSheet();
$rows=[];$total=0;$conflicts=[];$existing=[];$niks=[];
for($i=4;$i<=$sheet->getHighestDataRow();$i++){
$name=trim((string)$sheet->getCell('B'.$i)->getValue());if(!$name)continue;
preg_match('/^([A-Z]+)\s+No\.\s*(\d+)$/i',$sheet->getCell('E'.$i)->getValue(),$m);$code=strtoupper($m[1]).'-'.str_pad($m[2],2,'0',STR_PAD_LEFT);
$lot=DB::table('kavling_peta')->where('id_lokasi',10)->where('kode_kavling',$code)->first();
$c=$lot?DB::table('customer')->where('id_kavling',$lot->id)->where('stt_arsip',0)->get():collect();
$r=['row'=>$i,'name'=>$name,'nik'=>(string)$sheet->getCell('C'.$i)->getValue(),'phone'=>(string)$sheet->getCell('D'.$i)->getValue(),'code'=>$code,'unit_id'=>$lot?->id,'price'=>(int)$sheet->getCell('G'.$i)->getValue(),'purchase'=>(string)$sheet->getCell('H'.$i)->getValue(),'paid'=>(int)$sheet->getCell('J'.$i)->getValue(),'note'=>(string)$sheet->getCell('K'.$i)->getValue(),'existing_customers'=>$c->map(fn($x)=>['id'=>$x->id,'name'=>$x->nama_lengkap,'purchase'=>$x->jenis_pembelian,'nik'=>$x->nik])->all()];
if(!$lot||$c->count()>1||($c->count()===1&&strcasecmp($name,trim($c[0]->nama_lengkap))!==0))$conflicts[]=$r;
elseif($c->count())$existing[]=['code'=>$code,'name'=>$name,'customer_id'=>$c[0]->id];
$niks[$r['nik']][]=$code.' '.$name;$total+=$r['paid'];$rows[]=$r;
}
$report=['count'=>count($rows),'total_paid'=>$total,'existing_matches'=>count($existing),'conflicts'=>$conflicts,'duplicate_niks'=>array_filter($niks,fn($x)=>count($x)>1),'rows'=>$rows];
file_put_contents(__DIR__.'/booking-preflight.json',json_encode($report,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE));unset($report['rows']);echo json_encode($report,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE).PHP_EOL;
