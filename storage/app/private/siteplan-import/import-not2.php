<?php
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$source='D:/Downloads/Telegram Desktop/DATA KONSUMEN KSV NOT-2.xlsx';
$sheet=PhpOffice\PhpSpreadsheet\IOFactory::load($source)->getActiveSheet();
$location=DB::table('lokasi_kavling')->where('nama_kavling','Kedamaian Sky View')->sole();
$rows=[];$seen=[];
foreach($sheet->toArray(null,false,true,true) as $line=>$r){
 if($line<4||!trim((string)$r['B']))continue;
 if(!preg_match('/^([A-Z]+)\s+No\.\s*(\d+)$/i',$r['E'],$m))throw new RuntimeException('Invalid unit');
 $code=$m[1].'-'.str_pad($m[2],2,'0',STR_PAD_LEFT);
 if(isset($seen[$code]))throw new RuntimeException('Duplicate unit');$seen[$code]=true;
 if(in_array($code,['H-10','L-09'],true))continue;
 $lot=DB::table('kavling_peta')->where('id_lokasi',$location->id)->where('kode_kavling',$code)->sole();
 $rows[]=['row'=>$line,'code'=>$code,'unit_id'=>$lot->id,'name'=>trim($r['B']),'nik'=>(string)$r['C'],'phone'=>(string)$r['D'],
 'price'=>(int)preg_replace('/[^0-9]/','',(string)$r['G']),'paid'=>(int)preg_replace('/[^0-9]/','',(string)$r['J']),
 'purchase'=>$code==='C-10'?'Pembelian Cash':trim($r['H']),'note'=>trim($r['K']),'sp3k'=>str_contains(strtoupper($r['K']),'SP3K')];
}
if(count($rows)!==83||array_sum(array_column($rows,'paid'))!==655000000)throw new RuntimeException('Unexpected source totals');
$reportPath=__DIR__.'/not2-import-report.json';
if(file_exists($reportPath))throw new RuntimeException('Already imported');
$summary=['count'=>count($rows),'total_paid'=>array_sum(array_column($rows,'paid')),'sp3k'=>count(array_filter($rows,fn($r)=>$r['sp3k'])),'skipped'=>['H-10','L-09']];
if(!in_array('--apply',$argv,true)){echo json_encode($summary).PHP_EOL;exit;}
DB::transaction(function()use($rows,$source,$location,$summary,$reportPath){
 $backup=[];foreach(['customer','pengajuan_hold','kavling_peta','persyaratan_legal','wawancara','wawancara_sp3k','bank_kpr'] as $t)$backup[$t]=DB::table($t)->lockForUpdate()->get();
 $backupPath=__DIR__.'/before-not2-'.date('Ymd-His').'.json';
 if(file_put_contents($backupPath,json_encode($backup,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT))===false)throw new RuntimeException('Backup failed');
 $imported=[];
 foreach($rows as $r){
  $reg='IMP-KSV-NOT2-'.$r['code'];
  if(DB::table('pengajuan_hold')->where('no_registrasi',$reg)->exists()||DB::table('customer')->where('id_kavling',$r['unit_id'])->where('stt_arsip',0)->exists()||DB::table('pengajuan_hold')->where('id_kavling',$r['unit_id'])->whereIn('stt_reg',[1,2])->exists())throw new RuntimeException('Occupied/duplicate '.$r['code']);
  if($r['paid']<=0||$r['paid']>$r['price']||!preg_match('/^\d{16}$/',$r['nik']))throw new RuntimeException('Invalid data');
  $note='Impor DATA KONSUMEN KSV NOT-2.xlsx baris '.$r['row'].'. Keterangan: '.$r['note'].'. NIK duplikat dipertahankan sesuai instruksi pengguna. Tanggal historis, metode pembayaran, rekening dan detail surat belum tersedia. Nominal pembayaran disimpan pada booking; jurnal pemasukan menunggu tanggal dan metode pembayaran.';
  $cid=DB::table('customer')->insertGetId(['kode_customer'=>$reg,'id_lokasi'=>$location->id,'id_kavling'=>$r['unit_id'],'nama_lengkap'=>$r['name'],'nik'=>$r['nik'],'no_telp'=>$r['phone'],'hrg_jual'=>$r['price'],'total_harga'=>$r['price'],'jenis_pembelian'=>$r['purchase'],'id_marketing'=>0,'id_status_progres'=>$r['sp3k']?4:2,'stt_arsip'=>0]);
  $bid=DB::table('pengajuan_hold')->insertGetId(['no_registrasi'=>$reg,'tgl_booking'=>null,'nama_lengkap'=>$r['name'],'nik'=>$r['nik'],'no_telp'=>$r['phone'],'id_lokasi'=>$location->id,'id_kavling'=>$r['unit_id'],'total_harga'=>$r['price'],'booking_fee'=>$r['paid'],'jenis_pembelian'=>$r['purchase'],'id_marketing'=>0,'stt_reg'=>2,'id_bank'=>null,'id_metode_bayar'=>null,'harga_snapshot'=>json_encode(['total_harga'=>$r['price'],'jenis_pembelian'=>$r['purchase'],'import_note'=>$note,'source_paid'=>$r['paid'],'source_status'=>$r['note']],JSON_THROW_ON_ERROR)]);
  DB::table('kavling_peta')->where('id',$r['unit_id'])->update(['id_customer'=>$cid,'hrg_jual'=>$r['price']]);
  DB::table('persyaratan_legal')->insert(['id_customer'=>$cid,'catatan_kekurangan'=>$note]);
  $sid=null;
  if($r['sp3k']){
   $bankId=0;
   if(preg_match('/\b(BRI|BTN)\b/i',$r['note'],$m)){
    $banks=DB::table('bank_kpr')->whereRaw('UPPER(TRIM(nama)) = ?',[strtoupper($m[1])])->get();
    if($banks->count()>1)throw new RuntimeException('Ambiguous bank');
    $bankId=$banks->count()?$banks[0]->id:DB::table('bank_kpr')->insertGetId(['nama'=>strtoupper($m[1])]);
   }
   $wid=DB::table('wawancara')->insertGetId(['id_customer'=>$cid,'tgl_wawancara'=>null,'id_bank_kpr'=>$bankId,'catatan_wawancara'=>$note,'status'=>2]);
   $sid=DB::table('wawancara_sp3k')->insertGetId(['id_wawancara'=>$wid,'id_bank_kpr'=>$bankId,'acc_plafon'=>null,'tenor'=>null,'id_notaris'=>0,'tgl_terbit_sp3k'=>null,'no_sp3k'=>null,'tgl_expired'=>null,'catatan_acc'=>$note,'status'=>1]);
  }
  $imported[]=$r+['customer_id'=>$cid,'booking_id'=>$bid,'sp3k_id'=>$sid];
 }
 $ids=array_column($imported,'booking_id');
 if(DB::table('pengajuan_hold')->whereIn('id',$ids)->count()!==83||(int)DB::table('pengajuan_hold')->whereIn('id',$ids)->sum('booking_fee')!==$summary['total_paid'])throw new RuntimeException('Verification failed');
 if(DB::table('wawancara_sp3k')->whereIn('id',array_filter(array_column($imported,'sp3k_id')))->count()!==$summary['sp3k'])throw new RuntimeException('SP3K count mismatch');
 $report=$summary+['source'=>$source,'sha256'=>hash_file('sha256',$source),'backup'=>$backupPath,'rows'=>$imported,'financial_ledger'=>'Pending actual payment date and method'];
 if(file_put_contents($reportPath.'.pending',json_encode($report,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE))===false)throw new RuntimeException('Report failed');
});
rename($reportPath.'.pending',$reportPath);echo json_encode($summary+['report'=>$reportPath]).PHP_EOL;

