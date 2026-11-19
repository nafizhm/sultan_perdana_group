<?php
// Run without --apply to preview. Dates must be supplied from the user's instruction.
require getcwd().'/vendor/autoload.php';
$app=require getcwd().'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
use Illuminate\Support\Facades\DB;
$options=getopt('', ['apply','date:','skip-conflicts','cash-c10']);
$source='D:/Downloads/Telegram Desktop/DATA KONSUMEN KSV NOT-1.xlsx';
$sheet=PhpOffice\PhpSpreadsheet\IOFactory::load($source)->getActiveSheet();
$location=DB::table('lokasi_kavling')->where('nama_kavling','Kedamaian Sky View')->sole();
$rows=[];$conflicts=[];
for($line=4;$line<=$sheet->getHighestDataRow();$line++) {
    $name=trim((string)$sheet->getCell('B'.$line)->getValue());
    if($name==='') continue;
    $raw=(string)$sheet->getCell('E'.$line)->getValue();
    if(!preg_match('/^([A-Z]+)\s+No\.\s*(\d+)$/i',$raw,$m)) throw new RuntimeException('Invalid unit at row '.$line);
    $code=strtoupper($m[1]).'-'.str_pad($m[2],2,'0',STR_PAD_LEFT);
    if(isset($rows[$code])) throw new RuntimeException('Duplicate unit '.$code);
    $lots=DB::table('kavling_peta')->where('id_lokasi',$location->id)->where('kode_kavling',$code)->get();
    $row=['row'=>$line,'code'=>$code,'name'=>$name,'nik'=>(string)$sheet->getCell('C'.$line)->getValue(),
        'phone'=>(string)$sheet->getCell('D'.$line)->getValue(),'price'=>(int)$sheet->getCell('G'.$line)->getValue(),
        'paid'=>(int)$sheet->getCell('J'.$line)->getValue(),'purchase'=>(string)$sheet->getCell('H'.$line)->getValue(),
        'note'=>(string)$sheet->getCell('K'.$line)->getValue(),'unit_id'=>$lots->count()===1?$lots[0]->id:null];
    if(!preg_match('/^\d{16}$/',$row['nik'])||$row['paid']<=0||$row['price']<$row['paid']) throw new RuntimeException('Invalid identity/amount at row '.$line);
    $row['registration']='IMP-KSV-NOT1-'.$code;
    if($code==='C-10'&&isset($options['cash-c10'])) $row['purchase']='Pembelian Cash';
    $imported=DB::table('pengajuan_hold')->where('no_registrasi',$row['registration'])->first();
    $row['already_imported']=(bool)$imported;
    if(!$row['unit_id']) $conflicts[]=$row+['reason'=>'Kavling tidak ditemukan atau ambigu'];
    elseif(!$imported&&(DB::table('customer')->where('id_kavling',$row['unit_id'])->where('stt_arsip',0)->exists()
        ||DB::table('pengajuan_hold')->where('id_kavling',$row['unit_id'])->whereIn('stt_reg',[1,2])->exists())) {
        $conflicts[]=$row+['reason'=>'Kavling sudah digunakan'];
    }
    $rows[$code]=$row;
}
if(count($rows)!==89||array_sum(array_column($rows,'paid'))!==688000000) throw new RuntimeException('Unexpected source totals');
$excluded=array_column($conflicts,'code');
$eligible=array_filter($rows,fn($r)=>!in_array($r['code'],$excluded,true)&&!$r['already_imported']);
$summary=['source'=>$source,'sha256'=>hash_file('sha256',$source),'source_rows'=>count($rows),
    'eligible'=>count($eligible),'payment_total'=>array_sum(array_column($eligible,'paid')),'conflicts'=>$conflicts];
if(!isset($options['apply'])) {echo json_encode($summary,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE).PHP_EOL;exit;}
if($conflicts&&!isset($options['skip-conflicts'])) throw new RuntimeException('Resolve conflicts or explicitly select --skip-conflicts');
$date=$options['date']??'';
$d=DateTimeImmutable::createFromFormat('!Y-m-d',$date);
if(!$d||$d->format('Y-m-d')!==$date) throw new RuntimeException('A valid user-specified --date=YYYY-MM-DD is required; source has no date');
$stamp=date('Ymd-His');
$reportPath=__DIR__.'/booking-import-'.$stamp.'.json';
$backupPath=__DIR__.'/before-booking-import-'.$stamp.'.json';
DB::transaction(function()use($eligible,$date,$location,$summary,$backupPath,$reportPath){
    $backup=[];
    foreach(['pengajuan_hold','customer','pemasukan','piutang','persyaratan_legal','kavling_peta','metode_bayar'] as $table) $backup[$table]=DB::table($table)->lockForUpdate()->get()->all();
    if(file_put_contents($backupPath,json_encode($backup,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT))===false) throw new RuntimeException('Backup failed');
    $transfer=DB::table('metode_bayar')->whereRaw('LOWER(TRIM(jenis_bayar)) = ?', ['transfer'])->get();
    if($transfer->count()>1) throw new RuntimeException('Ambiguous Transfer payment method');
    $transferId=$transfer->count()?$transfer[0]->id:DB::table('metode_bayar')->insertGetId(['jenis_bayar'=>'Transfer']);
    $imported=[];
    foreach($eligible as $row){
        if(DB::table('pengajuan_hold')->where('no_registrasi',$row['registration'])->exists()) throw new RuntimeException('Concurrent duplicate import');
        if(DB::table('customer')->where('id_kavling',$row['unit_id'])->where('stt_arsip',0)->exists()) throw new RuntimeException('Unit now occupied '.$row['code']);
        $note='Impor DATA KONSUMEN KSV NOT-1.xlsx baris '.$row['row'].'. Keterangan sumber: '.$row['note'].'. Tanggal menggunakan tanggal yang ditetapkan saat impor; tanggal historis dan rekening tidak tersedia di sumber. Metode Transfer ditetapkan oleh admin.';
        $customerId=DB::table('customer')->insertGetId(['kode_customer'=>$row['registration'],'id_lokasi'=>$location->id,
            'id_kavling'=>$row['unit_id'],'nama_lengkap'=>$row['name'],'nik'=>$row['nik'],'no_telp'=>$row['phone'],
            'hrg_jual'=>$row['price'],'total_harga'=>$row['price'],'jenis_pembelian'=>$row['purchase'],'id_marketing'=>0,'id_status_progres'=>2,'stt_arsip'=>0]);
        $bookingId=DB::table('pengajuan_hold')->insertGetId(['no_registrasi'=>$row['registration'],'tgl_booking'=>$date,
            'nama_lengkap'=>$row['name'],'nik'=>$row['nik'],'no_telp'=>$row['phone'],'id_lokasi'=>$location->id,
            'id_kavling'=>$row['unit_id'],'total_harga'=>$row['price'],'booking_fee'=>$row['paid'],
            'jenis_pembelian'=>$row['purchase'],'id_marketing'=>0,'stt_reg'=>2,'id_bank'=>null,'id_metode_bayar'=>$transferId,
            'harga_snapshot'=>json_encode(['id_kavling'=>$row['unit_id'],'jenis_pembelian'=>$row['purchase'],'total_harga'=>$row['price'],
                'tenor'=>0,'dp'=>0,'rincian_biaya'=>[['nama'=>'Harga Rumah','nilai'=>$row['price']]],'import_note'=>$note],JSON_THROW_ON_ERROR)]);
        DB::table('kavling_peta')->where('id',$row['unit_id'])->update(['id_customer'=>$customerId]);
        DB::table('persyaratan_legal')->insert(['id_customer'=>$customerId,'catatan_kekurangan'=>$note.' Identitas selain NIK dan telepon serta berkas belum tersedia.']);
        $billId=DB::table('piutang')->insertGetId(['id_customer'=>$customerId,'id_bank'=>0,'tanggal_piutang'=>$date,
            'deskripsi'=>'Harga Rumah KSV '.$row['code'].' (sumber impor)','nominal'=>$row['price'],'status'=>1,
            'terbayar'=>$row['paid'],'sisa_bayar'=>$row['price']-$row['paid'],'id_kategori_transaksi'=>0]);
        $paymentId=DB::table('pemasukan')->insertGetId(['id_customer'=>$customerId,'id_lokasi'=>$location->id,'id_bank'=>0,
            'id_metode_bayar'=>$transferId,'id_piutang'=>$billId,'tanggal'=>$date,'nominal'=>$row['paid'],
            'no_kwitansi'=>$row['registration'],'id_kategori_transaksi'=>0,'keterangan_kategori'=>'Tanda Jadi (Booking)',
            'keterangan'=>'Pembayaran historis KSV '.$row['code'].'. '.$note]);
        $imported[]=$row+['booking_id'=>$bookingId,'customer_id'=>$customerId,'piutang_id'=>$billId,'pemasukan_id'=>$paymentId];
    }
    $ids=array_column($imported,'pemasukan_id');
    if((int)DB::table('pemasukan')->whereIn('id',$ids)->sum('nominal')!==array_sum(array_column($eligible,'paid'))) throw new RuntimeException('Payment total mismatch');
    $report=$summary+['payment_method'=>'Transfer','transfer_id'=>$transferId,'date_used'=>$date,'backup'=>$backupPath,'imported'=>$imported];
    if(file_put_contents($reportPath.'.pending',json_encode($report,JSON_THROW_ON_ERROR|JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE))===false) throw new RuntimeException('Report failed');
});
rename($reportPath.'.pending',$reportPath);
echo json_encode(['imported'=>count($eligible),'payment_total'=>array_sum(array_column($eligible,'paid')),'report'=>$reportPath],JSON_PRETTY_PRINT).PHP_EOL;
