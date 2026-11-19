<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('wawancara_sp3k', function (Blueprint $table) {
            $table->date('tgl_terbit_sp3k')->nullable()->change();
            $table->string('no_sp3k')->nullable()->change();
            $table->integer('acc_plafon')->nullable()->change();
            $table->integer('tenor')->nullable()->change();
        });
    }

    public function down(): void
    {
        // Unknown historical values cannot safely be converted to required values.
        if (\Illuminate\Support\Facades\DB::table('wawancara_sp3k')->whereNull('tgl_terbit_sp3k')->orWhereNull('no_sp3k')->orWhereNull('acc_plafon')->orWhereNull('tenor')->exists()) {
            throw new RuntimeException('Lengkapi detail SP3K historis sebelum rollback.');
        }
        Schema::table('wawancara_sp3k', function (Blueprint $table) {
            $table->date('tgl_terbit_sp3k')->nullable(false)->change();
            $table->string('no_sp3k')->nullable(false)->change();
            $table->integer('acc_plafon')->nullable(false)->change();
            $table->integer('tenor')->nullable(false)->change();
        });
    }
};
