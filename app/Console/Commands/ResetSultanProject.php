<?php
namespace App\Console\Commands;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
class ResetSultanProject extends Command
{
    protected $signature = 'project:reset-sultan {--execute : Hapus data bisnis pada database lokal Sultan}';
    protected $description = 'Kosongkan data perusahaan lama dan siapkan identitas PT Sultan';
    public function handle(): int
    {
        if (!app()->environment('local') || DB::connection()->getDatabaseName() !== 'sultan_perdana_lampung'
            || !in_array(config('database.connections.mysql.host'), ['localhost', '127.0.0.1'])) {
            $this->error('Reset hanya diizinkan pada database lokal sultan_perdana_lampung.'); return self::FAILURE;
        }
        $keep = ['migrations','menu','role','role_user','menu_panduan_aplikasi','hak_akses_panduan_apk','progres_list_penjualan'];
        $tables = array_column(Schema::getTables(), 'name');
        $this->line('Database: '.DB::connection()->getDatabaseName());
        $this->line('Tabel yang dikosongkan: '.implode(', ', array_diff($tables, $keep)));
        if (!$this->option('execute')) return self::SUCCESS;
        $admin = DB::table('users')->where('username', 'master')->where('id_role', 1)->first();
        if (!$admin) { $this->error('Admin master tidak ditemukan.'); return self::FAILURE; }
        Schema::disableForeignKeyConstraints();
        try {
            DB::transaction(function () use ($tables, $keep, $admin) {
                foreach (array_diff($tables, $keep) as $table) DB::table($table)->delete();
                DB::table('users')->insert(['id'=>1,'surname'=>'Administrator Sultan','username'=>'master','password'=>$admin->password,'email'=>'','status'=>'AKTIF','id_role'=>1,'id_marketing'=>0]);
                foreach (DB::table('menu')->pluck('id') as $menu) DB::table('hak_akses')->insert(['id_user'=>1,'id_menu'=>$menu,'lihat'=>1,'beranda'=>1,'tambah'=>1,'edit'=>1,'hapus'=>1]);
                DB::table('konfigurasi')->insert(['id'=>1,'nama_perusahaan'=>'PT. SULTAN PERDANA GRUP','alamat'=>'Jl. Moh Ali, Kelurahan Kedaung, Kecamatan Kemiling, Bandar Lampung 35151','email'=>'','telp'=>'','hape'=>'08138796668','npwp_perusahaan'=>'','front_page'=>0,'folder_svg'=>'']);
                foreach (['Logo Login','Logo Aplikasi','fav icon','Logo Rekap'] as $i=>$kind) DB::table('konfigurasi_media')->insert(['jenis_data'=>$kind,'keterangan'=>$kind.' PT Sultan','nama_file'=>'sultan-logo.png','urutan'=>$i+1,'jenis_download'=>0,'stt_aktif'=>1]);
            });
        } finally { Schema::enableForeignKeyConstraints(); }
        $this->info('Data bisnis kosong. Akses master dipertahankan dengan password sebelumnya.');
        return self::SUCCESS;
    }
}

