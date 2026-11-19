<?php

namespace Tests\Feature;

use App\Http\Controllers\Transaksi\AkadController;
use App\Models\Akad;
use App\Models\AkadDetail;
use App\Models\Customer;
use App\Models\KavlingPeta;
use App\Models\LokasiKavling;
use App\Models\PersyaratanLegal;
use App\Models\Wawancara;
use App\Models\WawancaraSp3k;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class HistoricalAkadTest extends TestCase
{
    public function test_registered_participants_without_sp3k_are_visible_in_both_filters(): void
    {
        $this->assertSame('sqlite', config('database.default'));
        $this->assertSame(':memory:', config('database.connections.sqlite.database'));
        foreach ([new Akad, new AkadDetail, new Customer, new KavlingPeta, new LokasiKavling, new PersyaratanLegal, new Wawancara, new WawancaraSp3k] as $model) {
            Schema::create($model->getTable(), function (Blueprint $table) use ($model) {
                $table->id();
                foreach (array_unique($model->getFillable()) as $field) {
                    if ($field !== 'id') $table->string($field)->nullable();
                }
            });
        }
        DB::table('akad')->insert(['id'=>1, 'tgl_akad'=>'2026-10-06']);
        DB::table('lokasi_kavling')->insert(['id'=>1, 'nama_kavling'=>'Kedamaian Sky View']);
        DB::table('kavling_peta')->insert(['id'=>1, 'kode_kavling'=>'F-08']);
        DB::table('customer')->insert([
            ['id'=>1, 'nama_lengkap'=>'Yohanes', 'id_lokasi'=>1, 'id_kavling'=>1, 'stt_arsip'=>0],
            ['id'=>2, 'nama_lengkap'=>'Archived', 'id_lokasi'=>1, 'id_kavling'=>1, 'stt_arsip'=>1],
            ['id'=>3, 'nama_lengkap'=>'Unregistered', 'id_lokasi'=>1, 'id_kavling'=>1, 'stt_arsip'=>0],
        ]);
        foreach ([1,2] as $id) DB::table('detail_akad')->insert(['id_akad'=>1, 'id_customer'=>$id, 'status'=>2]);
        foreach ([1,2] as $filter) {
            $request = Request::create('/akad/1', 'GET', ['filter'=>$filter], [], [], ['HTTP_X_REQUESTED_WITH'=>'XMLHttpRequest']);
            $this->app->instance('request', $request);
            $data = (new AkadController)->show($request, 1)->getData(true);
            $this->assertSame(1, $data['recordsTotal']);
            $this->assertSame('Yohanes', strip_tags($data['data'][0]['nama_lengkap']));
            $this->assertStringContainsString('F-08', $data['data'][0]['lokasi_rumah']);
        }
        $this->assertSame(0, DB::table('wawancara')->count());
        $this->assertSame(0, DB::table('wawancara_sp3k')->count());
    }
}
