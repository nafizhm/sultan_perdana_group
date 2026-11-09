<?php

namespace Database\Seeders;

use App\Models\PengaturanMedia;
use Illuminate\Database\Seeder;

class PengaturanMediaSeeder extends Seeder
{
    public function run(): void
    {
        PengaturanMedia::create([
            'jenis_data' => 'Logo Login',
            'keterangan' => 'Logo yang ditampilkan pada halaman login',
            'nama_file' => 'sultan-logo.png',
            'urutan' => 1,
            'jenis_download' => 0,
            'stt_aktif' => 1,
        ]);

        PengaturanMedia::create([
            'jenis_data' => 'Logo Aplikasi',
            'keterangan' => 'Logo yang ditampilkan pada sidebar aplikasi setelah login',
            'nama_file' => 'sultan-logo.png',
            'urutan' => 2,
            'jenis_download' => 0,
            'stt_aktif' => 1,
        ]);

        PengaturanMedia::create([
            'jenis_data' => 'fav icon',
            'keterangan' => 'Icon kecil yang ditampilkan pada tab browser',
            'nama_file' => 'sultan-logo.png',
            'urutan' => 3,
            'jenis_download' => 0,
            'stt_aktif' => 1,
        ]);

    }
}
