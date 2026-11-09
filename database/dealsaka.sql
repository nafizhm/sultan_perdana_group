-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 05, 2026 at 09:00 AM
-- Server version: 8.0.30
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dealsaka`
--

-- --------------------------------------------------------

--
-- Table structure for table `aduan`
--

CREATE TABLE `aduan` (
  `id` int NOT NULL,
  `no_aduan` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` date NOT NULL,
  `id_kavling` int NOT NULL,
  `id_customer` int NOT NULL,
  `no_kontrak` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_aduan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_aduan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aduan_proses`
--

CREATE TABLE `aduan_proses` (
  `id` int NOT NULL,
  `id_aduan` int NOT NULL,
  `tgl_update` date NOT NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_proses_aduan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `akad`
--

CREATE TABLE `akad` (
  `id` int NOT NULL,
  `tgl_akad` date NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `balik_nama`
--

CREATE TABLE `balik_nama` (
  `id` int NOT NULL,
  `id_kavling` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_customer` int NOT NULL,
  `nama_pengganti` varchar(225) NOT NULL,
  `stt_balik` enum('sudah','belum') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id` int NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_rek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pemilik_rek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_kpr`
--

CREATE TABLE `bank_kpr` (
  `id` int NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank_kpr`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id` int NOT NULL,
  `sku` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_satuan` int NOT NULL,
  `id_supplier` int NOT NULL,
  `stok_awal` int NOT NULL,
  `stok_minimal` int NOT NULL DEFAULT '0',
  `stok` int NOT NULL,
  `harga_beli` int NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `harga_jual` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `jenis_proyek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_proyek_bangunan` int DEFAULT NULL,
  `id_proyek_jalan` int DEFAULT NULL,
  `id_proyek_saluran` int DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar_detail`
--

CREATE TABLE `barang_keluar_detail` (
  `id` int NOT NULL,
  `id_barang_keluar` int NOT NULL,
  `id_barang` int NOT NULL,
  `jumlah` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `id_po` int NOT NULL,
  `nama_penerima` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk_detail`
--

CREATE TABLE `barang_masuk_detail` (
  `id` int NOT NULL,
  `id_masuk` int NOT NULL,
  `id_barang` int NOT NULL,
  `jumlah` int NOT NULL,
  `harga_beli` int NOT NULL,
  `sub_total` int NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bast`
--

CREATE TABLE `bast` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `tanggal_bast` date NOT NULL,
  `no_bast` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bphtb_ssp`
--

CREATE TABLE `bphtb_ssp` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_kavling` int NOT NULL,
  `status_bphtb` enum('ada','tidak ada') NOT NULL,
  `status_ssp` enum('ada','tidak ada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `id` int NOT NULL,
  `jenis_content` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `judul` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_item` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `artikel` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int NOT NULL,
  `kode_customer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_verif` timestamp NULL DEFAULT NULL,
  `id_lokasi` int DEFAULT NULL,
  `id_kavling` int DEFAULT NULL,
  `hrg_jual` bigint DEFAULT NULL,
  `biaya_surat` bigint DEFAULT NULL,
  `peningkatan_mutu` bigint DEFAULT NULL,
  `total_harga` bigint DEFAULT NULL,
  `estimasi_plafon` bigint DEFAULT '0',
  `sbum` bigint DEFAULT '0',
  `id_status_progres` int DEFAULT NULL,
  `nama_lengkap` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat_lahir` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat_ktp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `alamat_domisili` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status_pernikahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik_p` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_bpjs_kes` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_perumahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npwp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_marketing` int DEFAULT NULL,
  `id_freelance` int DEFAULT NULL,
  `jenis_pembelian` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `an_surat_cash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termin_x_cash_b` int DEFAULT '0',
  `stt_arsip` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer_tempo`
--

CREATE TABLE `customer_tempo` (
  `id` int NOT NULL,
  `kode_customer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_verif` timestamp NULL DEFAULT NULL,
  `id_lokasi` int DEFAULT NULL,
  `id_kavling` int DEFAULT NULL,
  `hrg_jual` bigint DEFAULT NULL,
  `biaya_surat` bigint DEFAULT NULL,
  `peningkatan_mutu` bigint DEFAULT NULL,
  `total_harga` bigint DEFAULT NULL,
  `id_status_progres` int DEFAULT NULL,
  `nama_lengkap` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat_lahir` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat_ktp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `alamat_domisili` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status_pernikahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik_p` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_bpjs_kes` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_perumahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npwp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_marketing` int DEFAULT NULL,
  `id_freelance` int DEFAULT NULL,
  `jenis_pembelian` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `an_surat_cash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termin_x_cash_b` int DEFAULT '0',
  `stt_arsip` int NOT NULL DEFAULT '0',
  `id_user` int NOT NULL,
  `id_customer` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_akad`
--

CREATE TABLE `detail_akad` (
  `id` bigint UNSIGNED NOT NULL,
  `id_akad` int NOT NULL,
  `id_customer` int NOT NULL,
  `id_persyaratan` int NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_akad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_aduan`
--

CREATE TABLE `file_aduan` (
  `id_file_aduan` int NOT NULL,
  `id_aduan` int NOT NULL,
  `id_customer` int NOT NULL,
  `no_kontrak` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_proses_aduan`
--

CREATE TABLE `file_proses_aduan` (
  `id` int NOT NULL,
  `id_aduan` int NOT NULL,
  `nama_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foto_progres`
--

CREATE TABLE `foto_progres` (
  `id` int NOT NULL,
  `id_progres_pembangunan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kavling` int NOT NULL,
  `file_foto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foto_proyek_bangunan`
--

CREATE TABLE `foto_proyek_bangunan` (
  `id` int NOT NULL,
  `id_proyek_bangunan_detail` int NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foto_proyek_jalan`
--

CREATE TABLE `foto_proyek_jalan` (
  `id` int NOT NULL,
  `id_proyek_jalan_detail` int NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foto_proyek_saluran`
--

CREATE TABLE `foto_proyek_saluran` (
  `id` int NOT NULL,
  `id_proyek_saluran_detail` int NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ganti_nama`
--

CREATE TABLE `ganti_nama` (
  `id` int NOT NULL,
  `tgl_ganti` date NOT NULL,
  `id_customer_lama` int NOT NULL,
  `id_customer_baru` int NOT NULL,
  `biaya_ganti_nama` int NOT NULL,
  `lampiran_bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan_ganti` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ganti_namas`
--

CREATE TABLE `ganti_namas` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hak_akses`
--

CREATE TABLE `hak_akses` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_menu` int NOT NULL,
  `lihat` int NOT NULL,
  `beranda` int NOT NULL DEFAULT '0',
  `tambah` int NOT NULL,
  `edit` int NOT NULL,
  `hapus` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hak_akses`
--

-- --------------------------------------------------------

--
-- Table structure for table `hak_akses_panduan_apk`
--

CREATE TABLE `hak_akses_panduan_apk` (
  `id` int NOT NULL,
  `id_role` int NOT NULL,
  `id_menu_panduan` int NOT NULL,
  `akses` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hutang`
--

CREATE TABLE `hutang` (
  `id` int NOT NULL,
  `tanggal_hutang` date NOT NULL,
  `id_bank` int NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `terbayar` int NOT NULL,
  `sisa_bayar` int NOT NULL,
  `tgl_pelunasan` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `input_po`
--

CREATE TABLE `input_po` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `id_supplier` int NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jum_item` int NOT NULL,
  `total_harga` int NOT NULL,
  `terbayar` int NOT NULL,
  `status` int NOT NULL,
  `lampiran_po` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_bank` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `input_po_detail`
--

CREATE TABLE `input_po_detail` (
  `id` int NOT NULL,
  `id_po` int NOT NULL,
  `id_barang` int NOT NULL,
  `jumlah` int NOT NULL,
  `harga_beli` int NOT NULL,
  `sub_total` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `input_po_pembayaran`
--

CREATE TABLE `input_po_pembayaran` (
  `id` int NOT NULL,
  `id_po` int NOT NULL,
  `tanggal` date NOT NULL,
  `terbayar` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int NOT NULL,
  `tgl_invoice` date NOT NULL,
  `no_invoice` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_customer` int NOT NULL,
  `id_kavling` int NOT NULL,
  `nama_customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `perumahan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_kavling` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `ppn` int NOT NULL,
  `ppn_nominal` int NOT NULL,
  `total` int NOT NULL,
  `stt_bayar` int NOT NULL,
  `stt_delete_inv` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jalan`
--

CREATE TABLE `jalan` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `panjang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lebar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `luas` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pekerjaan_bangunan`
--

CREATE TABLE `jenis_pekerjaan_bangunan` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `jenis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentasi` decimal(5,2) NOT NULL,
  `harga` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pekerjaan_jalan`
--

CREATE TABLE `jenis_pekerjaan_jalan` (
  `id` int NOT NULL,
  `jenis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentasi` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pekerjaan_saluran`
--

CREATE TABLE `jenis_pekerjaan_saluran` (
  `id` int NOT NULL,
  `jenis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentasi` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_transaksi`
--

CREATE TABLE `kategori_transaksi` (
  `id` int NOT NULL,
  `kode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kategori` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_fix` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kavling_peta`
--

CREATE TABLE `kavling_peta` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_projek` int DEFAULT NULL,
  `cluster` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `blok` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_perusahaan` int NOT NULL DEFAULT '0',
  `kode_kavling` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `panjang_kanan` double(11,1) DEFAULT NULL,
  `panjang_kiri` double(11,1) DEFAULT NULL,
  `lebar_depan` double(11,1) DEFAULT NULL,
  `lebar_belakang` double(11,1) DEFAULT NULL,
  `luas_tanah` double(11,1) DEFAULT NULL,
  `tipe_bangunan` double(11,1) DEFAULT NULL,
  `daya_listrik` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `luas_bangunan` double(11,1) DEFAULT NULL,
  `hrg_meter` int DEFAULT NULL,
  `hrg_jual` int DEFAULT NULL,
  `biaya_surat` int DEFAULT NULL,
  `peningkatan_mutu` int DEFAULT NULL,
  `id_rumah_sikumbang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_sertifikat` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_map` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `map` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `matrik` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `keterangan` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `atas_nama_surat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_customer` int DEFAULT NULL,
  `tgl_jatuh_tempo` int DEFAULT NULL,
  `stt_cicilan` int DEFAULT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_ready` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kavling_peta`
--

-- --------------------------------------------------------

--
-- Table structure for table `konfigurasi`
--

CREATE TABLE `konfigurasi` (
  `id` int NOT NULL,
  `nama_perusahaan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hape` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `npwp_perusahaan` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `front_page` int NOT NULL,
  `folder_svg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `konfigurasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `konfigurasi_media`
--

CREATE TABLE `konfigurasi_media` (
  `id` int NOT NULL,
  `jenis_data` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_file` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int NOT NULL,
  `jenis_download` int NOT NULL,
  `stt_aktif` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `konfigurasi_media`
--

-- --------------------------------------------------------

--
-- Table structure for table `konfigurasi_wa`
--

CREATE TABLE `konfigurasi_wa` (
  `id` int NOT NULL,
  `api_key` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_key` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legal`
--

CREATE TABLE `legal` (
  `id` int NOT NULL,
  `id_kavling` int NOT NULL,
  `ukuran` int NOT NULL,
  `luas` int NOT NULL,
  `no_shm` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `atas_nama` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_pengajuan` date NOT NULL,
  `tgl_proses` date NOT NULL,
  `tgl_release` date NOT NULL,
  `tgl_serah_terima` date NOT NULL,
  `tgl_data` date NOT NULL,
  `status_legal` int NOT NULL,
  `lampiran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_legal` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listrik_air`
--

CREATE TABLE `listrik_air` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_kavling` int NOT NULL,
  `norek_listrik` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_listrik` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_listrik_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `norek_air` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_air` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_air_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_aktivitas_pengguna`
--

CREATE TABLE `log_aktivitas_pengguna` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `aktivitas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_aktivitas_pengguna`
--

-- --------------------------------------------------------

--
-- Table structure for table `lokasi_kavling`
--

CREATE TABLE `lokasi_kavling` (
  `id` int NOT NULL,
  `nama_kavling` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_singkat` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int NOT NULL,
  `stt_tampil` int NOT NULL DEFAULT '0',
  `header` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_cluster` tinyint(1) NOT NULL DEFAULT '0',
  `no_kwitansi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_bast` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_ppjb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reset_nomor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lokasi_kavling`
--

-- --------------------------------------------------------

--
-- Table structure for table `lokasi_kavling_perusahaan`
--

CREATE TABLE `lokasi_kavling_perusahaan` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_perusahaan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lokasi_kavling_perusahaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `marketing_freelance`
--

CREATE TABLE `marketing_freelance` (
  `id` int NOT NULL,
  `kode_freelance` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_freelance` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` int NOT NULL,
  `alamat` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sosmed` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `foto` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_bank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_rekening` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `atas_nama` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketing_offline`
--

CREATE TABLE `marketing_offline` (
  `id` int NOT NULL,
  `kode_marketing` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_marketing` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` int NOT NULL,
  `alamat` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sosmed` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_bank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_rekening` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `atas_nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_svg`
--

CREATE TABLE `master_svg` (
  `id` int NOT NULL,
  `id_lokasi` int NOT NULL,
  `header_xml` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_svg` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `polygon_svg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path_svg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_svg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `footer_svg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lebar` int NOT NULL,
  `tinggi` int NOT NULL,
  `ukuran_dashboard` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_svg`
--

text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd\"\r\nviewBox=\"0 0 40000 29700\"\r\n xmlns:xlink=\"http://www.w3.org/1999/xlink\">\r\n <defs>\r\n  <font id=\"FontID0\" horiz-adv-x=\"647\" font-variant=\"normal\" style=\"fill-rule:nonzero\" font-style=\"normal\" font-weight=\"400\">\r\n	<font-face \r\n		font-family=\"Bahnschrift\">\r\n		<font-face-src>\r\n			<font-face-name name=\"Bahnschrift\"/>\r\n		</font-face-src>\r\n	</font-face>\r\n   <missing-glyph><path d=\"M0 0z\"/></missing-glyph>\r\n   <glyph unicode=\"D\" horiz-adv-x=\"656\" d=\"M155.338 0l0 94.6567 160.663 0c52.3396,0 92.9964,13.667 121.667,40.8391 28.8323,27.172 43.3295,65.5004 43.3295,115.005l0 208.994c0,49.505 -14.4972,87.8333 -43.3295,115.005 -28.6704,27.172 -69.3272,40.6568 -121.667,40.6568l-160.663 0 0 94.8389 157.667 0c85.9908,0 152.321,-22.1709 199.498,-66.6545 46.9943,-44.5038 70.5015,-107.008 70.5015,-187.835l0 -201.178c0,-53.6557 -10.5084,-99.4958 -31.667,-137.318 -21.1788,-38.0044 -51.9954,-67.019 -92.3283,-87.0032 -40.3329,-20.0045 -89.1697,-30.0067 -146.51,-30.0067l-157.161 0zm-67.5049 0l0 709.996 99.6578 0 0 -709.996 -99.6578 0z\"/>\r\n   <glyph unicode=\"3\" horiz-adv-x=\"528\" d=\"M256.839 -7.32957c-40.0089,0 -75.1787,7.32957 -105.165,21.6647 -30.1687,14.4972 -54.3441,35.4937 -72.506,62.8278 -18.3442,27.334 -30.0067,60.4993 -35.1698,99.6781l0 0 101.5 0 0 0c4.49493,-30.6748 16.6636,-53.0078 36.1619,-67.181 19.4983,-14.1529 44.5038,-21.3205 75.1787,-21.3205 32.8211,0 58.4948,8.82788 76.6567,26.3217 18.1619,17.676 27.334,42.3374 27.334,74.3485l0 21.4825c0,35.514 -8.6659,62.848 -25.8357,82.1843 -17.3318,19.4983 -41.6692,29.1563 -73.3362,29.1563l-50.1529 0 0 94.677 50.1529 0c28.0022,0 49.6669,8.32169 64.8525,24.8233 14.9831,16.6636 22.6569,40.1709 22.6569,70.3395l0 21.9887c0,28.0022 -8.15971,49.6669 -24.1754,65.0145 -16.1574,15.3273 -38.9965,22.8188 -68.659,22.8188 -25.0056,0 -46.3261,-6.98536 -63.6579,-21.1586 -17.514,-14.1732 -29.5005,-36.5061 -35.9999,-67.1607l0 0 -101.014 0 0 0c10.1642,58.6568 32.6793,103.991 67.6669,135.982 35.0078,32.1732 79.3497,48.1686 133.005,48.1686 61.1675,0 108.506,-16.1574 142.177,-48.3306 33.4892,-32.3351 50.1529,-77.6691 50.1529,-136.326l0 -11.6625c0,-35.514 -9.49604,-66.3306 -28.6704,-92.5105 -19.316,-26.1597 -46.4881,-45.496 -81.6579,-57.8266 38.8346,-8.15971 68.8412,-27.172 90.1618,-56.9965 21.3408,-29.6827 32.0112,-67.5049 32.0112,-113.507l0 -11.6625c0,-62.1798 -17.838,-110.328 -53.3317,-144.506 -35.514,-34.1574 -85.5049,-51.3272 -150.337,-51.3272z\"/>\r\n   <glyph unicode=\"A\" horiz-adv-x=\"647\" d=\"M19.4983 0l261.84 709.996 84.8367 0 261.819 -709.996 -107.494 0 -196.825 572.84 -196.683 -572.84 -107.494 0zm120.675 155.824l0 94.677 373.484 0 0 -94.677 -373.484 0z\"/>\r\n   <glyph unicode=\"0\" horiz-adv-x=\"551\" d=\"M275.831 -7.32957c-67.6669,0 -118.326,18.1619 -151.997,54.5061 -33.6715,36.1619 -50.4971,85.3226 -50.4971,147.158l0 322.825c0,62.848 16.9876,112.009 51.1652,147.847 34.1574,35.8177 84.6747,53.8177 151.329,53.8177 67.1607,0 117.678,-17.8177 151.673,-53.4937 33.9954,-35.6557 51.0033,-85.1607 51.0033,-148.171l0 -322.825c0,-62.8278 -17.0078,-112.171 -51.0033,-148.009 -33.9954,-35.8177 -84.5127,-53.6557 -151.673,-53.6557zm0 94.6567c36.5061,0 62.8278,9.67827 78.8435,28.6704 16.1574,19.0123 24.1552,45.172 24.1552,78.3373l0 322.825c0,33.5095 -7.99773,59.6692 -24.1552,78.4993 -16.0157,19.0123 -42.3374,28.3464 -78.8435,28.3464 -36.3239,0 -62.6658,-9.33406 -78.8232,-28.3464 -16.1777,-18.8301 -24.1754,-44.9898 -24.1754,-78.4993l0 -322.825c0,-33.1653 7.99773,-59.325 24.1754,-78.3373 16.1574,-18.9921 42.4993,-28.6704 78.8232,-28.6704z\"/>\r\n   <glyph unicode=\"-\" horiz-adv-x=\"479\" d=\"M78.1753 301.828l328.15 0 0 -94.8187 -328.15 0 0 94.8187z\"/>\r\n   <glyph unicode=\"8\" horiz-adv-x=\"562\" d=\"M281.338 -7.32957c-43.3295,0 -81.1719,8.15971 -113.345,24.4994 -32.3351,16.1574 -57.3205,39.1585 -75.1584,68.821 -18,29.5005 -26.8278,64.1843 -26.8278,104.011l0 11.6625c0,35.4937 8.82788,68.8412 26.4836,100.164 17.838,31.181 41.5072,54.83 71.0077,70.6635 -24.6614,13.667 -44.6658,33.5095 -59.9931,59.3452 -15.3475,25.9977 -23.0011,53.1697 -23.0011,81.8198l0 17.1698c0,56.1664 18.3239,101.338 54.992,135.516 36.6681,33.9954 85.1809,50.983 145.842,50.983 60.4993,0 108.992,-16.9876 145.66,-50.983 36.6681,-34.1777 54.992,-79.3497 54.992,-135.516l0 -17.1698c0,-29.3183 -7.81551,-56.8143 -23.325,-82.488 -15.3273,-25.6737 -35.8379,-45.334 -61.1675,-58.677 30.0067,-15.8335 53.9999,-39.4825 71.9998,-70.6635 18,-31.3228 27.0101,-64.6703 27.0101,-100.164l0 -11.6625c0,-39.8267 -8.84812,-74.5105 -26.8481,-104.011 -17.8177,-29.6625 -42.8233,-52.6635 -75.1584,-68.821 -32.1732,-16.3397 -69.9953,-24.4994 -113.163,-24.4994zm0 95.6691c34.8256,0 62.8278,10.0022 84.1685,29.9864 21.3205,20.1664 31.9909,46.3464 31.9909,79.0054l0 6.84363c0,32.8211 -10.6704,59.325 -31.9909,79.3294 -21.3408,20.0045 -49.343,29.9864 -84.1685,29.9864 -34.8458,0 -63.01,-9.98198 -84.3305,-29.9864 -21.3408,-20.0045 -32.0112,-46.6703 -32.0112,-79.8356l0 -7.32957c0,-32.6793 10.6704,-58.677 32.0112,-78.3373 21.3205,-19.8425 49.4847,-29.6625 84.3305,-29.6625zm0 320.82c30.1687,0 54.668,9.67827 73.1539,28.8323 18.5061,19.1743 27.8402,44.6658 27.8402,76.1708l0 6.84363c0,30.3306 -9.33406,54.668 -27.8402,72.992 -18.4859,18.3442 -42.9853,27.496 -73.1539,27.496 -30.3306,0 -54.83,-9.15184 -73.3362,-27.496 -18.5061,-18.3239 -27.8402,-42.8233 -27.8402,-73.4981l0 -7.32957c0,-31.181 9.33406,-56.3283 27.8402,-75.3407 18.5061,-19.1541 43.0055,-28.6704 73.3362,-28.6704z\"/>\r\n   <glyph unicode=\"F\" horiz-adv-x=\"558\" d=\"M87.8333 0l0 709.996 99.6578 0 0 -709.996 -99.6578 0zm48.8368 298.832l0 94.677 344.328 0 0 -94.677 -344.328 0zm0 316.325l0 94.8389 398.004 0 0 -94.8389 -398.004 0z\"/>\r\n   <glyph unicode=\"5\" horiz-adv-x=\"544\" d=\"M271.498 -7.32957c-53.9999,0 -98.3215,15.4893 -133.005,46.6703 -34.6636,30.9988 -56.4903,74.9965 -65.1562,131.487l0 0.506186 99.4958 0 0 -0.506186c3.66478,-25.9977 14.0112,-46.1641 31.343,-60.6613 17.1496,-14.4972 39.6647,-21.8267 67.3227,-21.8267 31.8289,0 56.5106,10.6704 74.0043,31.9909 17.3318,21.3408 25.9977,51.3272 25.9977,90.1618l0 59.5072c0,38.8346 -8.6659,68.659 -25.9977,89.8378 -17.4938,21.1586 -42.1754,31.8289 -74.0043,31.8289 -17.3318,0 -33.8334,-5.00111 -49.8289,-14.6591 -15.9955,-9.84025 -30.0067,-23.5073 -41.9932,-41.001l-90.8502 0 0 373.99 361.842 0 0 -94.8389 -262.164 0 0 -159.651c12.3307,10.1642 26.1597,18 41.487,23.487 15.3475,5.5073 30.8368,8.34194 46.8525,8.34194 61.8154,0 109.66,-18.9921 143.493,-56.8345 33.9954,-38.0044 50.821,-91.4981 50.821,-160.501l0 -59.5072c0,-69.3272 -17.3318,-122.983 -52.1574,-160.987 -34.8256,-37.8424 -84.0066,-56.8345 -147.502,-56.8345z\"/>\r\n   <glyph unicode=\"C\" horiz-adv-x=\"618\" d=\"M320.334 -7.32957c-49.505,0 -92.8344,10.9944 -129.826,33.0033 -37.1743,21.9887 -66.0066,52.8255 -86.5172,92.4902 -20.4904,39.6647 -30.6546,86.173 -30.6546,139.161l0 194.841c0,53.3317 10.1642,100.002 30.6546,139.667 20.5106,39.6647 49.343,70.5015 86.5172,92.5105 36.992,21.9887 80.3215,32.9831 129.826,32.9831 41.001,0 78.4993,-8.82788 112.495,-26.4836 33.9954,-17.514 62.5038,-42.0134 85.5049,-73.6804 23.0011,-31.505 38.4904,-68.497 46.6703,-110.834l0 0 -102.168 0 0 0c-6.17546,22.8391 -16.5017,42.6816 -30.9988,59.8311 -14.4972,17.1698 -31.505,30.3509 -51.0033,39.8469 -19.4983,9.33406 -39.6647,14.1529 -60.4993,14.1529 -43.6737,0 -78.6612,-15.4893 -105.165,-46.1641 -26.6659,-30.8368 -39.8267,-71.3317 -39.8267,-121.829l0 -194.841c0,-50.4971 13.1608,-90.9919 39.8267,-121.667 26.5039,-30.4926 61.4914,-45.8199 105.165,-45.8199 30.8368,0 59.9931,9.82 87.3271,29.3385 27.334,19.4983 45.8402,47.6624 55.1742,84.4925l0 0 102.168 0 0 0c-8.17996,-42.3374 -23.8312,-79.3294 -46.9943,-110.834 -23.0011,-31.667 -51.5094,-56.1664 -85.3429,-73.8424 -33.8334,-17.4938 -71.3317,-26.3217 -112.333,-26.3217z\"/>\r\n   <glyph unicode=\"2\" horiz-adv-x=\"516\" d=\"M62.5038 0l0 86.497 247.505 330.013c14.3149,18.8301 25.4915,38.4904 33.4892,58.6568 7.99773,20.1664 12.0067,39.1585 12.0067,56.9965l0 1.01237c0,28.3261 -8.34194,50.3148 -25.0056,65.9864 -16.5017,15.6715 -40.1709,23.3453 -70.6635,23.3453 -28.6704,0 -51.9954,-8.50392 -70.1776,-25.5118 -18,-17.1698 -28.9943,-41.325 -32.9831,-72.4858l0 -0.506186 -102.999 0 0 0.506186c8.82788,61.1472 31.1608,108.486 66.9987,142.319 35.6557,33.6715 81.8198,50.4971 138.168,50.4971 63.8199,0 112.981,-16.1574 147.826,-48.3306 34.8256,-32.3351 52.3396,-77.8311 52.3396,-136.832l0 -0.506186c0,-24.9853 -5.18334,-51.3272 -15.6715,-78.8232 -10.3464,-27.496 -24.8436,-53.6759 -43.5117,-78.8435l-205.491 -279.333 268.501 0 0 -94.6567 -400.332 0z\"/>\r\n   <glyph unicode=\"7\" horiz-adv-x=\"503\" d=\"M439.997 709.996l0 -88.8254 -183.664 -621.171 -105.995 0 183.664 615.157 -180.668 0 0 -101.986 -99.6578 0 0 196.825 386.321 0z\"/>\r\n   <glyph unicode=\"E\" horiz-adv-x=\"597\" d=\"M87.8333 0l0 709.996 99.6578 0 0 -709.996 -99.6578 0zm48.3306 0l0 94.6567 407.844 0 0 -94.6567 -407.844 0zm0 305.169l0 94.6567 354.006 0 0 -94.6567 -354.006 0zm0 309.988l0 94.8389 407.844 0 0 -94.8389 -407.844 0z\"/>\r\n   <glyph unicode=\"4\" horiz-adv-x=\"568\" d=\"M63.4959 108.83l0 86.497 238.332 514.163 102.513 0 -232.501 -508.332 348.154 0 0 -92.3283 -456.498 0zm306.161 -109.336l0 418.008 97.1674 0 0 -418.008 -97.1674 0z\"/>\r\n   <glyph unicode=\"1\" horiz-adv-x=\"332\" d=\"M244.67 709.996l0 -709.996 -99.6781 0 0 601.49 -100.994 -61.9976 0 102.999 100.994 67.5049 99.6781 0z\"/>\r\n   <glyph unicode=\"B\" horiz-adv-x=\"645\" d=\"M146.49 0l0 92.3283 192.351 0c52.8255,0 90.1618,10.0022 112.15,30.1687 21.847,20.1664 32.8413,46.8323 32.8413,79.6736l0 1.49831c0,35.1698 -9.33406,63.172 -28.0022,84.1685 -18.6681,20.9966 -49.505,31.505 -92.4902,31.505l-216.85 0 0 89.8176 216.85 0c36.6681,0 64.488,8.6659 83.1562,26.1799 18.8301,17.3318 28.1642,42.8233 28.1642,76.3328l0 0c0,35.4937 -10.4882,61.9976 -31.3228,79.6534 -20.8346,17.514 -51.9954,26.3419 -93.6646,26.3419l-203.183 0 0 92.3283 221.183 0c69.9953,0 121.991,-17.4938 156.33,-52.3396 34.1574,-34.8256 51.1652,-81.4959 51.1652,-140.153l0 0c0,-35.3318 -10.3262,-67.8289 -31.1608,-97.3294 -20.8346,-29.5005 -53.6759,-48.3508 -98.1798,-56.3486 43.8357,-6.49942 78.0133,-25.9977 102.33,-58.1506 24.1754,-32.1732 36.3441,-69.1854 36.3441,-110.834l0 -1.49831c0,-57.8469 -18.6681,-104.679 -56.1664,-140.173 -37.4982,-35.4937 -88.1775,-53.1697 -152.342,-53.1697l-229.505 0zm-58.6568 0l0 709.996 99.1719 0 0 -709.996 -99.1719 0z\"/>\r\n   <glyph unicode=\"9\" horiz-adv-x=\"513\" d=\"M146.004 0l178.663 352.508 -0.506186 -17.514c-8.32169,-15.3273 -20.9966,-26.3217 -37.4982,-33.1653 -16.6636,-6.82338 -35.8379,-10.3262 -57.6647,-10.3262 -51.1652,0 -92.3283,18.9921 -123.489,56.8345 -31.343,38.0044 -46.8525,88.3395 -46.8525,151.167l0 0.506186c0,68.983 17.352,122.497 52.0156,160.319 34.6636,38.0044 83.3181,56.9965 146.166,56.9965 62.8278,0 111.503,-19.1541 146.004,-57.4824 34.4814,-38.1866 51.8334,-92.3485 51.8334,-162.344l0 -0.506186c0,-28.8323 -4.33295,-60.1551 -12.8369,-93.9885 -8.34194,-33.6715 -20.8346,-66.5128 -37.0123,-98.8479l-151.329 -304.157 -107.494 0zm110.834 382.332c31.3228,0 55.4982,10.5084 72.4858,31.667 17.1698,21.1586 25.6737,51.0033 25.6737,89.4936l0 0.344206c0,37.4982 -8.50392,66.4925 -25.6737,87.0032 -16.9876,20.4904 -41.163,30.6546 -72.4858,30.6546 -31.505,0 -55.8424,-10.1642 -73.0122,-30.6546 -17.1496,-20.5106 -25.6535,-49.6669 -25.6535,-87.3474l0 -0.485938c0,-38.5106 8.50392,-68.1731 25.6535,-89.1697 17.1698,-20.9966 41.5072,-31.505 73.0122,-31.505z\"/>\r\n   <glyph unicode=\"6\" horiz-adv-x=\"513\" d=\"M256.332 -7.32957c-62.8278,0 -111.503,18.6681 -146.004,56.1664 -34.5016,37.4982 -51.6714,90.1618 -51.6714,158.173l0 0.485938c0,30.6748 4.17097,63.172 12.6749,97.5116 8.50392,34.3194 20.6726,67.3227 36.5061,99.3339l154.326 305.655 107.494 0 -181.154 -354.006 0.506186 17.514c16.8256,32.3351 46.9943,48.3306 90.3238,48.3306 55.6602,0 98.8277,-18.5061 129.341,-55.3362 30.6546,-36.992 46.0021,-89.1697 46.0021,-156.492l0 -0.506186c0,-68.659 -17.352,-121.991 -51.8334,-159.995 -34.5016,-37.8424 -83.3384,-56.8345 -146.51,-56.8345zm0 95.6691c31.9909,0 56.3283,9.82 73.3362,29.3183 16.8256,19.5185 25.3295,47.3385 25.3295,83.5004l0 0.506186c0,39.6647 -8.98986,70.3395 -26.8278,92.0043 -18,21.6647 -43.5117,32.4971 -76.677,32.4971 -29.6625,0 -52.6635,-10.8324 -68.821,-32.6591 -16.3397,-21.847 -24.4994,-52.6635 -24.4994,-92.3485l0 -0.485938c0,-36.1821 8.50392,-63.8401 25.6535,-83.1764 17.1698,-19.4983 41.3452,-29.1563 72.506,-29.1563z\"/>\r\n  </font>\r\n  <style type=\"text/css\">\r\n   <![CDATA[\r\n    @font-face { font-family:\"Bahnschrift\";font-variant:normal;font-style:normal;font-weight:normal;src:url(\"#FontID0\") format(svg)}\r\n    .fil4 {fill:none;fill-rule:nonzero}\r\n    .fil6 {fill:#332C2B}\r\n    .fil2 {fill:#FEFEFE;fill-rule:nonzero}\r\n    .fil1 {fill:#DCDDDD;fill-rule:nonzero}\r\n    .fil0 {fill:#332C2B;fill-rule:nonzero}\r\n    .fil5 {fill:#FDE9D2;fill-rule:nonzero}\r\n    .fil3 {fill:#A2D3AB;fill-rule:nonzero}\r\n    .fnt0 {font-weight:normal;font-size:493.89px;font-family:\'Bahnschrift\'}\r\n   ]]>\r\n  </style>\r\n </defs>\r\n <g id=\"Layer_x0020_1\">\r\n  <metadata id=\"CorelCorpID_0Corel-Layer\"/>\r\n  <g id=\"_2096178038048\">\r\n   <g>\r\n    <path class=\"fil0\" d=\"M15177 6444c3,0 5,1 7,2 4,2 6,4 9,7l700 444c4,-1 9,0 14,3 5,3 10,7 12,13l1261 798c6,0 12,1 18,4 5,4 9,9 11,15l1135 718c3,1 6,2 9,4 3,2 5,4 7,7l1135 719c5,0 9,1 12,4 4,2 7,5 9,9l1143 724c4,0 7,2 10,4 4,2 6,4 8,7l1134 718c5,0 9,2 13,4 4,3 7,6 9,10l4614 2922c1,0 2,1 3,1 1,1 2,2 3,2l1144 725c3,0 6,1 8,3 3,2 5,4 7,6l1150 728c2,1 4,2 5,3 2,1 3,2 4,3l1142 723c3,1 6,2 9,4 3,1 5,4 7,6l2300 1456c3,1 6,2 10,4 3,2 5,5 7,7l2394 1516c12,8 16,23 10,35l-997 1893c-1,2 -2,5 -3,7 -1,2 -2,3 -3,4l-2717 5159c-7,13 -23,18 -36,11l-20043 -11392c-12,-7 -17,-23 -10,-35l425 -910 -251 -142 -424 905c-7,13 -22,19 -35,13l-1457 -828c-2,-1 -4,-2 -6,-3 -1,0 -2,-1 -3,-2l-7987 -4538c-13,-8 -17,-24 -10,-36l4917 -8247c7,-13 24,-17 36,-9l1 0 5372 3405c2,1 3,2 5,3 1,1 3,2 4,3l3035 1924c12,7 16,23 9,35l-905 1930 242 153 900 -1923c6,-13 21,-19 35,-13l3 2 430 273z\"/>\r\n    <path class=\"fil0\" d=\"M30406 29209c-7,13 -23,18 -36,11 -13,-7 -18,-23 -11,-36l6596 -12206c7,-13 23,-18 36,-11 13,7 17,23 11,36l-6596 12206z\"/>\r\n    <path class=\"fil1\" d=\"M12948 8775c2,1 3,1 5,2 2,1 4,3 6,5l124 79 417 -889 -2085 -1320c-4,-1 -9,-2 -12,-4 -4,-3 -7,-6 -9,-10l-4613 -2921c-2,-1 -3,-1 -5,-2 -1,-1 -2,-2 -4,-3l-1829 -1159 -3331 5587 7757 4917c13,8 16,24 9,37l-2 1 -231 358 1410 801 414 -883 -372 -211 0 -1c-13,-7 -18,-23 -11,-35l179 -333 -7814 -4953c-13,-8 -16,-24 -8,-37l0 -1 1207 -2021c1,-4 2,-7 4,-11 2,-3 4,-5 7,-7l1091 -1827 0 -1 0 0 1 0 0 0 0 -1 0 0 1 -1 0 0 0 0 0 -1 1 0 0 0 0 -1 0 0 0 0 1 0 0 0 0 -1 0 0 1 -1 1 0 0 0 0 -1 0 0 1 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 2 -1 0 0 0 0 0 0 1 0 0 0c0,-1 1,-1 2,-1l0 0 1 -1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 -1 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 2 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 0 0 2 1 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 1 0 0 0 0 1 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 2 1 1249 791c2,1 3,2 5,2 1,1 2,2 4,4l2306 1460c2,1 4,2 6,3 2,1 4,3 5,4l1140 722c4,1 7,2 10,4 3,2 6,4 8,7l2298 1455c4,1 7,2 11,4 3,2 6,5 8,8l609 386z\"/>\r\n    <path class=\"fil1\" d=\"M11351 13587c-4,0 -7,-1 -10,-3 -4,-2 -7,-4 -9,-8l-20 -11 -414 885 14466 8222 969 -1530c1,-3 2,-5 3,-7 1,-3 3,-4 5,-6l1731 -2736c8,-12 24,-16 36,-8l1798 1136c6,0 11,1 16,4 5,3 8,8 10,13l1795 1134 2 1c12,8 16,24 8,37l-1743 2748 0 0 0 1 -860 1356 1762 1002 787 -1495 -542 -331c-3,-2 -6,-4 -8,-7l-50 -71c-1,-2 -2,-5 -3,-7l-27 -83c-1,-2 -2,-4 -2,-6l-15 -93c0,-3 0,-6 1,-10l21 -85 1 -4 35 -83c1,-2 2,-4 3,-6l1098 -1728c1,-2 2,-3 3,-4l55 -69c1,-2 4,-4 6,-6l71 -49c2,-2 4,-3 7,-4l82 -27c3,-1 6,-2 9,-2l85 -7c2,-1 4,0 6,0l92 14c2,0 5,1 7,2l78 35 3 2 275 177 618 -1173 -1359 -861c-6,0 -11,-1 -16,-4 -4,-3 -8,-7 -10,-12l-1143 -724 -1 -1 -2 -1 -1145 -725c-3,-1 -6,-2 -8,-3 -3,-2 -5,-4 -7,-6l-1150 -729c-2,0 -3,-1 -5,-2 -2,-1 -3,-2 -5,-4l-1140 -722c-3,-1 -7,-2 -10,-4 -3,-2 -5,-4 -7,-7l-1135 -719c-4,0 -9,-1 -13,-4 -4,-2 -7,-6 -9,-9l-1141 -723c-4,-1 -8,-2 -12,-4 -3,-3 -6,-6 -8,-9l-1132 -717c-5,0 -10,-1 -14,-4 -5,-3 -8,-7 -10,-11l-2294 -1453c-2,-1 -4,-1 -6,-3 -2,-1 -3,-2 -5,-4l-1155 -732 -2 0 -1 -1 -1145 -726c-3,0 -6,-2 -9,-3 -2,-2 -4,-4 -6,-6l-2301 -1457c-3,-1 -6,-2 -9,-4 -3,-2 -6,-4 -8,-7l-1134 -718c-5,-1 -9,-2 -13,-4 -4,-3 -7,-6 -9,-10l-1873 -1186 -1 -1c-2,-1 -3,-2 -4,-3l-304 -192 -416 889 259 164c3,0 6,1 8,3 4,2 7,4 10,8l4440 2811 1 1c12,8 16,24 8,37l-1144 1804c0,3 -2,6 -3,9 -2,3 -5,6 -7,8l-1325 2089c-8,13 -25,16 -37,9l0 -1 -1179 -669c-4,0 -7,-1 -11,-4 -3,-1 -5,-4 -7,-6l-3077 -1747z\"/>\r\n    <path class=\"fil0\" d=\"M29556 28841c-7,13 -23,18 -36,11 -13,-7 -18,-23 -11,-36l6504 -12348c6,-13 22,-18 35,-11 13,6 18,22 11,35l-6503 12349z\"/>\r\n    <path class=\"fil0\" d=\"M24776 16270c4,0 7,2 10,3 2,2 5,5 7,7l2450 1551 1 1c12,8 16,24 8,37l-2203 3471c-8,12 -24,16 -37,8l0 0 -1264 -719c-4,0 -7,-1 -11,-3 -2,-2 -5,-4 -7,-6l-2425 -1379c-4,0 -8,-2 -12,-4 -3,-2 -6,-5 -8,-7l-1176 -669c-5,0 -9,-2 -13,-4 -4,-2 -7,-5 -9,-8l-1179 -671c-1,0 -2,-1 -3,-1l0 -1 -1176 -668c-5,0 -10,-2 -14,-4 -3,-2 -6,-5 -8,-8l-1181 -672 0 0 -1 0 0 0 0 0 -1 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 0 0 0 0 -1 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 1 -1 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 1 -1 0 0 0 0 0 0 0 -1 0 0 0 0 0 -1 1 0 0 0 0 -1 0 0 0 0 0 0 1 -1 2444 -3868c8,-12 24,-16 36,-8l1147 725c5,0 10,1 15,4 5,4 9,8 11,13l1140 722c2,1 3,1 4,2 1,1 2,2 3,3l1144 724c2,0 5,1 8,3 2,2 5,4 6,6l1151 728c2,1 3,2 5,3 1,1 3,2 4,3l1141 723z\"/>\r\n    <polygon class=\"fil2\" points=\"13128,8889 13370,9042 13786,8154 13545,8001 \"/>\r\n    <polygon class=\"fil2\" points=\"11037,13349 11289,13491 13348,9091 13106,8937 \"/>\r\n    <path class=\"fil2\" d=\"M12950 8838l-2124 3950c-1,3 -2,6 -3,8 -1,1 -2,3 -3,4l-175 326 346 197 2070 -4414 -111 -71z\"/>\r\n    <polygon class=\"fil2\" points=\"11344,13523 13634,9272 13393,9119 11335,13518 \"/>\r\n    <polygon class=\"fil2\" points=\"14038,6824 13463,7886 13522,7924 \"/>\r\n    <polygon class=\"fil2\" points=\"14142,8316 15136,6480 14744,6231 13854,8134 \"/>\r\n   </g>\r\n   <path class=\"fil3\" d=\"M32949 21917l-277 -178 -72 -33 -86 -13 -79 6 -78 26 -65 45 -52 66 -1097 1727 -34 81 -19 78 13 85 26 79 44 63 535 326 1241 -2358zm-23850 -8491l220 -339 -7734 -4902 -433 726 7947 4515zm1691 -682l2115 -3934 -581 -368 -2388 3760 854 542zm2628 -4886l996 -1840 -686 -435 -1114 1766 804 509zm1763 -1350l-994 1837 684 433 986 -1842 -676 -428zm-1502 2792l-2289 4249 696 395 1261 -2339c1,-2 2,-4 3,-6 0,-1 1,-2 2,-3l1006 -1866 -679 -430zm20864 9468l-1114 1764 188 118 974 -1851 -48 -31z\"/>\r\n  </g>\r\n  <path class=\"fil4\" d=\"M5287 3924l1 1c13,7 17,23 9,36\"/>\r\n  <polyline class=\"fil4\" points=\"5252,3934 5252,3934 5252,3933 \"/>', '<g id=\"_2096178038208\">\r\n   <polygon class=\"fil5\" points=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"14850\"  class=\"fil6 fnt0\">[[4]]</text>\r\n   </g>\r\n  </g>', '<g id=\"_2096297423056\">\r\n   <path class=\"fil5\" d=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"14850\"  class=\"fil6 fnt0\">[[4]]</text>\r\n   </g>\r\n  </g>', '', ' </g>\r\n</svg>', 400, 100, 100),
(2, 2, '<?xml version=\"1.0\" encoding=\"UTF-8\"?>', '<svg id=\"svg-image-2\" xmlns=\"http://www.w3.org/2000/svg\" xml:space=\"preserve\" width=\"400mm\" height=\"297mm\" version=\"1.1\" style=\"shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd\"\r\nviewBox=\"0 0 40000 29700\"\r\n xmlns:xlink=\"http://www.w3.org/1999/xlink\">\r\n <defs>\r\n  <font id=\"FontID0\" horiz-adv-x=\"647\" font-variant=\"normal\" style=\"fill-rule:nonzero\" font-style=\"normal\" font-weight=\"400\">\r\n	<font-face \r\n		font-family=\"Bahnschrift\">\r\n		<font-face-src>\r\n			<font-face-name name=\"Bahnschrift\"/>\r\n		</font-face-src>\r\n	</font-face>\r\n   <missing-glyph><path d=\"M0 0z\"/></missing-glyph>\r\n   <glyph unicode=\"D\" horiz-adv-x=\"656\" d=\"M155.338 0l0 94.6567 160.663 0c52.3396,0 92.9964,13.667 121.667,40.8391 28.8323,27.172 43.3295,65.5004 43.3295,115.005l0 208.994c0,49.505 -14.4972,87.8333 -43.3295,115.005 -28.6704,27.172 -69.3272,40.6568 -121.667,40.6568l-160.663 0 0 94.8389 157.667 0c85.9908,0 152.321,-22.1709 199.498,-66.6545 46.9943,-44.5038 70.5015,-107.008 70.5015,-187.835l0 -201.178c0,-53.6557 -10.5084,-99.4958 -31.667,-137.318 -21.1788,-38.0044 -51.9954,-67.019 -92.3283,-87.0032 -40.3329,-20.0045 -89.1697,-30.0067 -146.51,-30.0067l-157.161 0zm-67.5049 0l0 709.996 99.6578 0 0 -709.996 -99.6578 0z\"/>\r\n   <glyph unicode=\"3\" horiz-adv-x=\"528\" d=\"M256.839 -7.32957c-40.0089,0 -75.1787,7.32957 -105.165,21.6647 -30.1687,14.4972 -54.3441,35.4937 -72.506,62.8278 -18.3442,27.334 -30.0067,60.4993 -35.1698,99.6781l0 0 101.5 0 0 0c4.49493,-30.6748 16.6636,-53.0078 36.1619,-67.181 19.4983,-14.1529 44.5038,-21.3205 75.1787,-21.3205 32.8211,0 58.4948,8.82788 76.6567,26.3217 18.1619,17.676 27.334,42.3374 27.334,74.3485l0 21.4825c0,35.514 -8.6659,62.848 -25.8357,82.1843 -17.3318,19.4983 -41.6692,29.1563 -73.3362,29.1563l-50.1529 0 0 94.677 50.1529 0c28.0022,0 49.6669,8.32169 64.8525,24.8233 14.9831,16.6636 22.6569,40.1709 22.6569,70.3395l0 21.9887c0,28.0022 -8.15971,49.6669 -24.1754,65.0145 -16.1574,15.3273 -38.9965,22.8188 -68.659,22.8188 -25.0056,0 -46.3261,-6.98536 -63.6579,-21.1586 -17.514,-14.1732 -29.5005,-36.5061 -35.9999,-67.1607l0 0 -101.014 0 0 0c10.1642,58.6568 32.6793,103.991 67.6669,135.982 35.0078,32.1732 79.3497,48.1686 133.005,48.1686 61.1675,0 108.506,-16.1574 142.177,-48.3306 33.4892,-32.3351 50.1529,-77.6691 50.1529,-136.326l0 -11.6625c0,-35.514 -9.49604,-66.3306 -28.6704,-92.5105 -19.316,-26.1597 -46.4881,-45.496 -81.6579,-57.8266 38.8346,-8.15971 68.8412,-27.172 90.1618,-56.9965 21.3408,-29.6827 32.0112,-67.5049 32.0112,-113.507l0 -11.6625c0,-62.1798 -17.838,-110.328 -53.3317,-144.506 -35.514,-34.1574 -85.5049,-51.3272 -150.337,-51.3272z\"/>\r\n   <glyph unicode=\"A\" horiz-adv-x=\"647\" d=\"M19.4983 0l261.84 709.996 84.8367 0 261.819 -709.996 -107.494 0 -196.825 572.84 -196.683 -572.84 -107.494 0zm120.675 155.824l0 94.677 373.484 0 0 -94.677 -373.484 0z\"/>\r\n   <glyph unicode=\"0\" horiz-adv-x=\"551\" d=\"M275.831 -7.32957c-67.6669,0 -118.326,18.1619 -151.997,54.5061 -33.6715,36.1619 -50.4971,85.3226 -50.4971,147.158l0 322.825c0,62.848 16.9876,112.009 51.1652,147.847 34.1574,35.8177 84.6747,53.8177 151.329,53.8177 67.1607,0 117.678,-17.8177 151.673,-53.4937 33.9954,-35.6557 51.0033,-85.1607 51.0033,-148.171l0 -322.825c0,-62.8278 -17.0078,-112.171 -51.0033,-148.009 -33.9954,-35.8177 -84.5127,-53.6557 -151.673,-53.6557zm0 94.6567c36.5061,0 62.8278,9.67827 78.8435,28.6704 16.1574,19.0123 24.1552,45.172 24.1552,78.3373l0 322.825c0,33.5095 -7.99773,59.6692 -24.1552,78.4993 -16.0157,19.0123 -42.3374,28.3464 -78.8435,28.3464 -36.3239,0 -62.6658,-9.33406 -78.8232,-28.3464 -16.1777,-18.8301 -24.1754,-44.9898 -24.1754,-78.4993l0 -322.825c0,-33.1653 7.99773,-59.325 24.1754,-78.3373 16.1574,-18.9921 42.4993,-28.6704 78.8232,-28.6704z\"/>\r\n   <glyph unicode=\"-\" horiz-adv-x=\"479\" d=\"M78.1753 301.828l328.15 0 0 -94.8187 -328.15 0 0 94.8187z\"/>\r\n   <glyph unicode=\"8\" horiz-adv-x=\"562\" d=\"M281.338 -7.32957c-43.3295,0 -81.1719,8.15971 -113.345,24.4994 -32.3351,16.1574 -57.3205,39.1585 -75.1584,68.821 -18,29.5005 -26.8278,64.1843 -26.8278,104.011l0 11.6625c0,35.4937 8.82788,68.8412 26.4836,100.164 17.838,31.181 41.5072,54.83 71.0077,70.6635 -24.6614,13.667 -44.6658,33.5095 -59.9931,59.3452 -15.3475,25.9977 -23.0011,53.1697 -23.0011,81.8198l0 17.1698c0,56.1664 18.3239,101.338 54.992,135.516 36.6681,33.9954 85.1809,50.983 145.842,50.983 60.4993,0 108.992,-16.9876 145.66,-50.983 36.6681,-34.1777 54.992,-79.3497 54.992,-135.516l0 -17.1698c0,-29.3183 -7.81551,-56.8143 -23.325,-82.488 -15.3273,-25.6737 -35.8379,-45.334 -61.1675,-58.677 30.0067,-15.8335 53.9999,-39.4825 71.9998,-70.6635 18,-31.3228 27.0101,-64.6703 27.0101,-100.164l0 -11.6625c0,-39.8267 -8.84812,-74.5105 -26.8481,-104.011 -17.8177,-29.6625 -42.8233,-52.6635 -75.1584,-68.821 -32.1732,-16.3397 -69.9953,-24.4994 -113.163,-24.4994zm0 95.6691c34.8256,0 62.8278,10.0022 84.1685,29.9864 21.3205,20.1664 31.9909,46.3464 31.9909,79.0054l0 6.84363c0,32.8211 -10.6704,59.325 -31.9909,79.3294 -21.3408,20.0045 -49.343,29.9864 -84.1685,29.9864 -34.8458,0 -63.01,-9.98198 -84.3305,-29.9864 -21.3408,-20.0045 -32.0112,-46.6703 -32.0112,-79.8356l0 -7.32957c0,-32.6793 10.6704,-58.677 32.0112,-78.3373 21.3205,-19.8425 49.4847,-29.6625 84.3305,-29.6625zm0 320.82c30.1687,0 54.668,9.67827 73.1539,28.8323 18.5061,19.1743 27.8402,44.6658 27.8402,76.1708l0 6.84363c0,30.3306 -9.33406,54.668 -27.8402,72.992 -18.4859,18.3442 -42.9853,27.496 -73.1539,27.496 -30.3306,0 -54.83,-9.15184 -73.3362,-27.496 -18.5061,-18.3239 -27.8402,-42.8233 -27.8402,-73.4981l0 -7.32957c0,-31.181 9.33406,-56.3283 27.8402,-75.3407 18.5061,-19.1541 43.0055,-28.6704 73.3362,-28.6704z\"/>\r\n   <glyph unicode=\"5\" horiz-adv-x=\"544\" d=\"M271.498 -7.32957c-53.9999,0 -98.3215,15.4893 -133.005,46.6703 -34.6636,30.9988 -56.4903,74.9965 -65.1562,131.487l0 0.506186 99.4958 0 0 -0.506186c3.66478,-25.9977 14.0112,-46.1641 31.343,-60.6613 17.1496,-14.4972 39.6647,-21.8267 67.3227,-21.8267 31.8289,0 56.5106,10.6704 74.0043,31.9909 17.3318,21.3408 25.9977,51.3272 25.9977,90.1618l0 59.5072c0,38.8346 -8.6659,68.659 -25.9977,89.8378 -17.4938,21.1586 -42.1754,31.8289 -74.0043,31.8289 -17.3318,0 -33.8334,-5.00111 -49.8289,-14.6591 -15.9955,-9.84025 -30.0067,-23.5073 -41.9932,-41.001l-90.8502 0 0 373.99 361.842 0 0 -94.8389 -262.164 0 0 -159.651c12.3307,10.1642 26.1597,18 41.487,23.487 15.3475,5.5073 30.8368,8.34194 46.8525,8.34194 61.8154,0 109.66,-18.9921 143.493,-56.8345 33.9954,-38.0044 50.821,-91.4981 50.821,-160.501l0 -59.5072c0,-69.3272 -17.3318,-122.983 -52.1574,-160.987 -34.8256,-37.8424 -84.0066,-56.8345 -147.502,-56.8345z\"/>\r\n   <glyph unicode=\"C\" horiz-adv-x=\"618\" d=\"M320.334 -7.32957c-49.505,0 -92.8344,10.9944 -129.826,33.0033 -37.1743,21.9887 -66.0066,52.8255 -86.5172,92.4902 -20.4904,39.6647 -30.6546,86.173 -30.6546,139.161l0 194.841c0,53.3317 10.1642,100.002 30.6546,139.667 20.5106,39.6647 49.343,70.5015 86.5172,92.5105 36.992,21.9887 80.3215,32.9831 129.826,32.9831 41.001,0 78.4993,-8.82788 112.495,-26.4836 33.9954,-17.514 62.5038,-42.0134 85.5049,-73.6804 23.0011,-31.505 38.4904,-68.497 46.6703,-110.834l0 0 -102.168 0 0 0c-6.17546,22.8391 -16.5017,42.6816 -30.9988,59.8311 -14.4972,17.1698 -31.505,30.3509 -51.0033,39.8469 -19.4983,9.33406 -39.6647,14.1529 -60.4993,14.1529 -43.6737,0 -78.6612,-15.4893 -105.165,-46.1641 -26.6659,-30.8368 -39.8267,-71.3317 -39.8267,-121.829l0 -194.841c0,-50.4971 13.1608,-90.9919 39.8267,-121.667 26.5039,-30.4926 61.4914,-45.8199 105.165,-45.8199 30.8368,0 59.9931,9.82 87.3271,29.3385 27.334,19.4983 45.8402,47.6624 55.1742,84.4925l0 0 102.168 0 0 0c-8.17996,-42.3374 -23.8312,-79.3294 -46.9943,-110.834 -23.0011,-31.667 -51.5094,-56.1664 -85.3429,-73.8424 -33.8334,-17.4938 -71.3317,-26.3217 -112.333,-26.3217z\"/>\r\n   <glyph unicode=\"2\" horiz-adv-x=\"516\" d=\"M62.5038 0l0 86.497 247.505 330.013c14.3149,18.8301 25.4915,38.4904 33.4892,58.6568 7.99773,20.1664 12.0067,39.1585 12.0067,56.9965l0 1.01237c0,28.3261 -8.34194,50.3148 -25.0056,65.9864 -16.5017,15.6715 -40.1709,23.3453 -70.6635,23.3453 -28.6704,0 -51.9954,-8.50392 -70.1776,-25.5118 -18,-17.1698 -28.9943,-41.325 -32.9831,-72.4858l0 -0.506186 -102.999 0 0 0.506186c8.82788,61.1472 31.1608,108.486 66.9987,142.319 35.6557,33.6715 81.8198,50.4971 138.168,50.4971 63.8199,0 112.981,-16.1574 147.826,-48.3306 34.8256,-32.3351 52.3396,-77.8311 52.3396,-136.832l0 -0.506186c0,-24.9853 -5.18334,-51.3272 -15.6715,-78.8232 -10.3464,-27.496 -24.8436,-53.6759 -43.5117,-78.8435l-205.491 -279.333 268.501 0 0 -94.6567 -400.332 0z\"/>\r\n   <glyph unicode=\"7\" horiz-adv-x=\"503\" d=\"M439.997 709.996l0 -88.8254 -183.664 -621.171 -105.995 0 183.664 615.157 -180.668 0 0 -101.986 -99.6578 0 0 196.825 386.321 0z\"/>\r\n   <glyph unicode=\"4\" horiz-adv-x=\"568\" d=\"M63.4959 108.83l0 86.497 238.332 514.163 102.513 0 -232.501 -508.332 348.154 0 0 -92.3283 -456.498 0zm306.161 -109.336l0 418.008 97.1674 0 0 -418.008 -97.1674 0z\"/>\r\n   <glyph unicode=\"1\" horiz-adv-x=\"332\" d=\"M244.67 709.996l0 -709.996 -99.6781 0 0 601.49 -100.994 -61.9976 0 102.999 100.994 67.5049 99.6781 0z\"/>\r\n   <glyph unicode=\"B\" horiz-adv-x=\"645\" d=\"M146.49 0l0 92.3283 192.351 0c52.8255,0 90.1618,10.0022 112.15,30.1687 21.847,20.1664 32.8413,46.8323 32.8413,79.6736l0 1.49831c0,35.1698 -9.33406,63.172 -28.0022,84.1685 -18.6681,20.9966 -49.505,31.505 -92.4902,31.505l-216.85 0 0 89.8176 216.85 0c36.6681,0 64.488,8.6659 83.1562,26.1799 18.8301,17.3318 28.1642,42.8233 28.1642,76.3328l0 0c0,35.4937 -10.4882,61.9976 -31.3228,79.6534 -20.8346,17.514 -51.9954,26.3419 -93.6646,26.3419l-203.183 0 0 92.3283 221.183 0c69.9953,0 121.991,-17.4938 156.33,-52.3396 34.1574,-34.8256 51.1652,-81.4959 51.1652,-140.153l0 0c0,-35.3318 -10.3262,-67.8289 -31.1608,-97.3294 -20.8346,-29.5005 -53.6759,-48.3508 -98.1798,-56.3486 43.8357,-6.49942 78.0133,-25.9977 102.33,-58.1506 24.1754,-32.1732 36.3441,-69.1854 36.3441,-110.834l0 -1.49831c0,-57.8469 -18.6681,-104.679 -56.1664,-140.173 -37.4982,-35.4937 -88.1775,-53.1697 -152.342,-53.1697l-229.505 0zm-58.6568 0l0 709.996 99.1719 0 0 -709.996 -99.1719 0z\"/>\r\n   <glyph unicode=\"9\" horiz-adv-x=\"513\" d=\"M146.004 0l178.663 352.508 -0.506186 -17.514c-8.32169,-15.3273 -20.9966,-26.3217 -37.4982,-33.1653 -16.6636,-6.82338 -35.8379,-10.3262 -57.6647,-10.3262 -51.1652,0 -92.3283,18.9921 -123.489,56.8345 -31.343,38.0044 -46.8525,88.3395 -46.8525,151.167l0 0.506186c0,68.983 17.352,122.497 52.0156,160.319 34.6636,38.0044 83.3181,56.9965 146.166,56.9965 62.8278,0 111.503,-19.1541 146.004,-57.4824 34.4814,-38.1866 51.8334,-92.3485 51.8334,-162.344l0 -0.506186c0,-28.8323 -4.33295,-60.1551 -12.8369,-93.9885 -8.34194,-33.6715 -20.8346,-66.5128 -37.0123,-98.8479l-151.329 -304.157 -107.494 0zm110.834 382.332c31.3228,0 55.4982,10.5084 72.4858,31.667 17.1698,21.1586 25.6737,51.0033 25.6737,89.4936l0 0.344206c0,37.4982 -8.50392,66.4925 -25.6737,87.0032 -16.9876,20.4904 -41.163,30.6546 -72.4858,30.6546 -31.505,0 -55.8424,-10.1642 -73.0122,-30.6546 -17.1496,-20.5106 -25.6535,-49.6669 -25.6535,-87.3474l0 -0.485938c0,-38.5106 8.50392,-68.1731 25.6535,-89.1697 17.1698,-20.9966 41.5072,-31.505 73.0122,-31.505z\"/>\r\n   <glyph unicode=\"6\" horiz-adv-x=\"513\" d=\"M256.332 -7.32957c-62.8278,0 -111.503,18.6681 -146.004,56.1664 -34.5016,37.4982 -51.6714,90.1618 -51.6714,158.173l0 0.485938c0,30.6748 4.17097,63.172 12.6749,97.5116 8.50392,34.3194 20.6726,67.3227 36.5061,99.3339l154.326 305.655 107.494 0 -181.154 -354.006 0.506186 17.514c16.8256,32.3351 46.9943,48.3306 90.3238,48.3306 55.6602,0 98.8277,-18.5061 129.341,-55.3362 30.6546,-36.992 46.0021,-89.1697 46.0021,-156.492l0 -0.506186c0,-68.659 -17.352,-121.991 -51.8334,-159.995 -34.5016,-37.8424 -83.3384,-56.8345 -146.51,-56.8345zm0 95.6691c31.9909,0 56.3283,9.82 73.3362,29.3183 16.8256,19.5185 25.3295,47.3385 25.3295,83.5004l0 0.506186c0,39.6647 -8.98986,70.3395 -26.8278,92.0043 -18,21.6647 -43.5117,32.4971 -76.677,32.4971 -29.6625,0 -52.6635,-10.8324 -68.821,-32.6591 -16.3397,-21.847 -24.4994,-52.6635 -24.4994,-92.3485l0 -0.485938c0,-36.1821 8.50392,-63.8401 25.6535,-83.1764 17.1698,-19.4983 41.3452,-29.1563 72.506,-29.1563z\"/>\r\n  </font>\r\n  <style type=\"text/css\">\r\n   <![CDATA[\r\n    @font-face { font-family:\"Bahnschrift\";font-variant:normal;font-style:normal;font-weight:normal;src:url(\"#FontID0\") format(svg)}\r\n    .fnt0_2 {fill:#332C2B}\r\n    .fil4_2 {fill:#FEFEFE;fill-rule:nonzero}\r\n    .fil1_2 {fill:#EEEEEF;fill-rule:nonzero}\r\n    .fil2_2 {fill:#DCDDDD;fill-rule:nonzero}\r\n    .fil0_2 {fill:#332C2B;fill-rule:nonzero}\r\n    .fil5_2 {fill:#FDE9D2;fill-rule:nonzero}\r\n    .fil3_2 {fill:#A2D3AB;fill-rule:nonzero}\r\n    .fnt0_2 {font-weight:normal;font-size:493.89px;font-family:\'Bahnschrift\'}\r\n   ]]>\r\n  </style>\r\n </defs>\r\n <g id=\"Layer_x0020_1\">\r\n  <metadata id=\"CorelCorpID_0Corel-Layer\"/>\r\n  <g id=\"_2096296796640\">\r\n   <path class=\"fil0_2\" d=\"M28077 27788c-7,13 -23,18 -36,11 -13,-6 -18,-22 -12,-35 1684,-3329 3326,-6544 5087,-9823l2830 -5505c7,-13 23,-18 36,-11 13,7 18,23 11,35 -1615,3142 -3213,6219 -4882,9328l-3034 6000zm-17166 -17706c-2,-1 -4,-1 -5,-2 -4,-2 -6,-4 -9,-6l-1377 -809c-6,1 -12,0 -17,-3 -5,-3 -9,-8 -11,-13l-1331 -781c-3,-1 -7,-2 -10,-4 -3,-2 -6,-4 -8,-7l-2536 -1489c-2,0 -3,-1 -4,-1 -1,-1 -2,-2 -3,-3l-2397 -1406c-1,-1 -1,-1 -2,-2 -1,0 -2,-1 -2,-1l-2400 -1409c-13,-7 -17,-23 -10,-36l1896 -3335c8,-13 24,-18 36,-10l19057 10822c2,0 4,1 7,3 1,1 2,2 3,3l11228 6376c13,7 17,23 11,35l-2053 3823c-7,13 -24,17 -36,10l-2082 -1222c-4,-1 -7,-2 -10,-4 -2,-2 -5,-4 -6,-6l-1856 -1089c-5,0 -10,-1 -15,-4 -4,-3 -7,-6 -9,-10l-7415 -4353c-6,1 -11,-1 -16,-4 -4,-2 -7,-6 -9,-10l-1931 -1133c-5,0 -10,-1 -15,-4 -4,-3 -7,-7 -9,-11l-2826 -1658c-5,0 -10,-1 -14,-4 -4,-3 -7,-6 -9,-10l-1187 -696c-3,-1 -6,-2 -9,-4 -4,-2 -6,-4 -8,-7l-1175 -689c-5,0 -9,-1 -14,-4 -4,-2 -7,-6 -9,-10l-1403 -823zm25395 4756c7,-13 23,-18 36,-11 13,7 18,23 11,36l-4007 7566 -3025 5981c-6,13 -22,18 -35,12 -13,-7 -18,-23 -12,-36l3025 -5981 0 0 0 0 0 -1 4007 -7566z\"/>\r\n   <g>\r\n    <polygon class=\"fil1_2\" points=\"30941,21777 32968,18002 31176,16984 28898,20578 \"/>\r\n    <path class=\"fil0_2\" d=\"M32078 18867l77 68c2,2 4,4 6,7l48 87c1,2 2,4 3,6l28 105c1,3 2,6 2,9l0 97c0,4 -1,7 -2,10l-39 98 -1 2 -544 1019c-1,2 -2,4 -3,6l-68 88c-2,2 -4,4 -6,5l-96 67c-3,2 -6,4 -10,5l-117 29c-2,1 -5,1 -8,1l-106 -10c-3,0 -7,0 -10,-2l-107 -49 -3 -1 -263 -166 0 0c-1,-1 -2,-2 -4,-3l-76 -67c-3,-2 -4,-4 -6,-7l-58 -97c-2,-2 -3,-5 -4,-9l-19 -106c-1,-2 -1,-5 0,-8l9 -105c0,-3 1,-6 2,-9l39 -97c1,-2 2,-4 3,-6l620 -969c1,-2 2,-3 3,-4l68 -88c2,-3 6,-5 9,-7l95 -48c2,-1 4,-2 7,-3l96 -28c3,-2 7,-2 11,-2l116 10c4,0 7,1 10,3l99 49 194 117 0 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0z\"/>\r\n    <path class=\"fil2_2\" d=\"M12563 6610c-135,304 -273,608 -415,912l397 232c6,-1 13,0 19,3 6,4 10,10 12,16l1177 691c2,1 5,2 7,3 3,2 5,4 6,5l1177 692c5,0 9,1 13,4 5,2 8,6 10,9l1273 749c1,0 1,0 2,1 12,7 16,24 8,36l-1471 2327 856 503 2153 -3412 -977 -555 -113 184c-8,12 -24,16 -36,9l-4098 -2409zm-769 703l423 -907 -9499 -5582 -492 866 1199 705c6,0 11,1 16,4 6,3 9,7 11,12l2373 1395c6,-1 13,0 19,3 5,3 9,9 11,14l1180 694c2,0 3,1 5,2 1,1 3,2 4,3l1182 694c6,-1 13,-1 20,3 6,4 10,10 12,16l1326 780c2,0 3,1 4,2 1,0 2,1 3,2l2203 1294zm12981 9676c0,0 0,1 -1,1l0 0 0 0 -2 2 0 0 0 0 -1 0 0 0 0 1 -1 0 0 0 0 0 -1 0 0 1 0 0 -1 0 0 0 0 0 -1 0 0 1 0 0 0 0 -1 0 0 0 -1 0 0 0 0 1 0 0 -1 0 0 0 -1 0 0 0 -1 0 0 0 0 0 -1 1 0 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 0 0 -1 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 0 0 -1 -1 0 0 0 0 -1 0 0 0 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 0 0 -1 -1 0 -1 0 0 -1 0 0 -1863 -1095c-5,0 -10,-1 -15,-4 -4,-3 -8,-6 -10,-10l-1865 -1097c0,-1 -1,-1 -2,-2 -12,-7 -16,-24 -8,-36l1658 -2613 -859 -488 -2197 3462 5514 3237 781 -1234c1,-3 2,-7 4,-10 3,-4 5,-7 9,-9l1449 -2289 -860 -488 -891 1397c0,3 -1,5 -2,6 -2,2 -3,4 -5,6l-802 1258 -1 1 0 0 0 0 0 0 -1 1 0 1 0 0 0 0 -1 1 0 0 0 0 0 0 -1 1z\"/>\r\n    <path class=\"fil3_2\" d=\"M12632 6454c-16,36 -31,72 -47,108l4080 2398 99 -160 -4132 -2346zm18978 13896l543 -1017 36 -91 0 -90 -27 -100 -45 -80 -73 -64 -192 -115 -91 -46 -107 -9 -90 28 -90 44 -64 83 -620 968 -37 92 -9 100 18 98 54 90 73 64 259 163 102 46 98 9 108 -27 89 -63 65 -83zm-20998 -10505l1159 -2484 -834 -490 -1382 2354 1057 620zm1514 -2275c-386,827 -789,1653 -1175,2474l179 105 1381 -2353 -385 -226zm113 -1212l47 -101 -6493 -3688 6446 3789z\"/>\r\n    <path class=\"fil4_2\" d=\"M11817 7388l-1159 2484 248 145 1164 -2480 -253 -149zm515 -1105l-47 102 254 150 47 -108 -254 -144zm-70 150l-423 907 253 149 425 -906 -255 -150z\"/>\r\n   </g>\r\n  </g>', '<g id=\"_2096296796704\">\r\n   <polygon class=\"fil5_2\" points=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"14850\"  class=\"fil6_2 fnt0_2\">[[4]]</text>\r\n   </g>\r\n  </g>', '<g id=\"_2096296850016\">\r\n   <path class=\"fil5_2\" d=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"14850\"  class=\"fil6_2 fnt0_2\">[[4]]</text>\r\n   </g>\r\n  </g>', '', ' </g>\r\n</svg>', 400, 100, 100);
text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd\"\r\nviewBox=\"0 0 40000 32500\"\r\n xmlns:xlink=\"http://www.w3.org/1999/xlink\">\r\n <defs>\r\n  <font id=\"FontID0\" horiz-adv-x=\"647\" font-variant=\"normal\" style=\"fill-rule:nonzero\" font-style=\"normal\" font-weight=\"400\">\r\n	<font-face \r\n		font-family=\"Bahnschrift\">\r\n		<font-face-src>\r\n			<font-face-name name=\"Bahnschrift\"/>\r\n		</font-face-src>\r\n	</font-face>\r\n   <missing-glyph><path d=\"M0 0z\"/></missing-glyph>\r\n   <glyph unicode=\"D\" horiz-adv-x=\"656\" d=\"M155.34 0l0 94.6779 160.655 0c52.3469,0 93.0007,13.6537 121.678,40.8192 28.8191,27.1656 43.3232,65.5045 43.3232,114.993l0 209.01c0,49.4886 -14.5041,87.8275 -43.3232,114.993 -28.6774,27.1656 -69.3313,40.6775 -121.678,40.6775l-160.655 0 0 94.8196 157.655 0c86.0086,0 152.34,-22.1577 199.513,-66.6619 46.9846,-44.5043 70.4887,-106.985 70.4887,-187.82l0 -201.167c0,-53.6697 -10.4883,-99.4968 -31.6538,-137.34 -21.1655,-38.0082 -52.0162,-66.9927 -92.3393,-87.0007 -40.3468,-20.008 -89.1739,-30.0002 -146.505,-30.0002l-157.159 0zm-67.5123 0l0 709.99 99.6622 0 0 -709.99 -99.6622 0z\"/>\r\n   <glyph unicode=\"3\" horiz-adv-x=\"528\" d=\"M256.845 -7.32289c-40.0161,0 -75.1896,7.32289 -105.166,21.6616 -30.1892,14.5041 -54.3548,35.5042 -72.5203,62.8351 -18.3309,27.3309 -30.0002,60.4965 -35.1499,99.6622l0 0 101.481 0 0 0c4.51185,-30.6617 16.6773,-53.0083 36.1656,-67.158 19.512,-14.1733 44.5043,-21.3545 75.1896,-21.3545 32.8113,0 58.4886,8.83472 76.6541,26.3388 18.1655,17.6694 27.3309,42.331 27.3309,74.3392l0 21.4962c0,35.5042 -8.66936,62.8351 -25.8191,82.1581 -17.3387,19.512 -41.6696,29.1735 -73.347,29.1735l-50.1736 0 0 94.6779 50.1736 0c27.9923,0 49.6776,8.31503 64.843,24.827 15.0001,16.6773 22.6537,40.1578 22.6537,70.3234l0 22.0159c0,27.9923 -8.14967,49.6539 -24.1655,64.9848 -16.1576,15.3308 -39.0003,22.8427 -68.6698,22.8427 -24.9923,0 -46.3232,-6.99218 -63.6619,-21.1655 -17.5041,-14.1733 -29.5042,-36.4964 -36.0003,-67.158l0 0 -100.985 0 0 0c10.1576,58.654 32.6459,103.985 67.6541,135.993 35.0081,32.1735 79.3235,48.1657 132.993,48.1657 61.1816,0 108.497,-16.1812 142.182,-48.3311 33.4963,-32.3388 50.15,-77.6699 50.15,-136.348l0 -11.6694c0,-35.4806 -9.49614,-66.3312 -28.6538,-92.481 -19.3466,-26.1734 -46.5122,-45.4964 -81.6621,-57.8508 38.835,-8.14967 68.8352,-27.1656 90.1661,-57.0004 21.3309,-29.6459 31.9845,-67.4887 31.9845,-113.481l0 -11.6694c0,-62.1737 -17.8348,-110.339 -53.3154,-144.497 -35.5042,-34.1814 -85.5125,-51.3311 -150.332,-51.3311z\"/>\r\n   <glyph unicode=\"A\" horiz-adv-x=\"647\" d=\"M19.4883 0l261.852 709.99 84.8274 0 261.829 -709.99 -107.505 0 -196.82 572.839 -196.679 -572.839 -107.505 0zm120.686 155.836l0 94.6543 373.491 0 0 -94.6543 -373.491 0z\"/>\r\n   <glyph unicode=\"0\" horiz-adv-x=\"551\" d=\"M275.837 -7.32289c-67.6777,0 -118.347,18.1655 -152.009,54.4965 -33.6617,36.1656 -50.5043,85.3235 -50.5043,147.167l0 322.821c0,62.8351 17.008,112.017 51.1658,147.828 34.1814,35.8349 84.6857,53.8351 151.348,53.8351 67.158,0 117.662,-17.8348 151.655,-53.4807 34.016,-35.6696 51.0004,-85.1818 51.0004,-148.182l0 -322.821c0,-62.8351 -16.9844,-112.182 -51.0004,-148.017 -33.9924,-35.8349 -84.4967,-53.6461 -151.655,-53.6461zm0 94.6543c36.4964,0 62.8351,9.66149 78.8274,28.6774 16.1576,18.9923 24.1655,45.1657 24.1655,78.3313l0 322.821c0,33.4963 -8.00794,59.6698 -24.1655,78.4967 -15.9923,19.0159 -42.331,28.3467 -78.8274,28.3467 -36.331,0 -62.6698,-9.33078 -78.8274,-28.3467 -16.1812,-18.8269 -24.1655,-45.0004 -24.1655,-78.4967l0 -322.821c0,-33.1656 7.98431,-59.339 24.1655,-78.3313 16.1576,-19.0159 42.4964,-28.6774 78.8274,-28.6774z\"/>\r\n   <glyph unicode=\"O\" horiz-adv-x=\"645\" d=\"M322.833 -7.3347c-50.1736,0 -94.0047,10.8426 -131.493,32.4924 -37.3468,21.6852 -66.3312,52.1933 -87.0243,91.5243 -20.6576,39.4728 -30.9687,85.3235 -30.9687,137.659l0 201.155c0,52.8311 10.3111,98.8236 30.9687,138.013 20.6931,39.1539 49.6776,69.662 87.0243,91.3117 37.4885,21.6852 81.3195,32.5278 131.493,32.5278 49.9965,0 93.8275,-10.8426 131.316,-32.5278 37.3468,-21.6498 66.5084,-52.1579 87.2015,-91.3117 20.6576,-39.1893 30.9687,-85.1818 30.9687,-138.013l0 -201.155c0,-52.3351 -10.3111,-98.1858 -30.9687,-137.659 -20.6931,-39.331 -49.8547,-69.8391 -87.2015,-91.5243 -37.4885,-21.6498 -81.3195,-32.4924 -131.316,-32.4924zm0 98.1504c44.5043,0 80.3274,14.6694 107.15,44.0082 26.8585,29.1616 40.1814,67.9966 40.1814,116.186l0 207.994c0,48.5083 -13.3229,87.3432 -40.1814,116.505 -26.823,28.9845 -62.6462,43.6539 -107.15,43.6539 -44.3271,0 -80.0085,-14.6694 -107.009,-43.6539 -27.0002,-29.1616 -40.5003,-67.9966 -40.5003,-116.505l0 -207.994c0,-48.1894 13.5001,-87.0243 40.5003,-116.186 27.0002,-29.3388 62.6816,-44.0082 107.009,-44.0082z\"/>\r\n   <glyph unicode=\"-\" horiz-adv-x=\"479\" d=\"M78.166 301.845l328.16 0 0 -94.8433 -328.16 0 0 94.8433z\"/>\r\n   <glyph unicode=\"I\" horiz-adv-x=\"275\" d=\"M187.513 710.013l0 -710.013 -99.674 0 0 710.013 99.674 0z\"/>\r\n   <glyph unicode=\"8\" horiz-adv-x=\"562\" d=\"M281.341 -7.32289c-43.3468,0 -81.166,8.14967 -113.339,24.4963 -32.3388,16.1576 -57.3312,39.1657 -75.1659,68.8352 -18.0001,29.4805 -26.8349,64.158 -26.8349,103.985l0 11.6694c0,35.5042 8.83472,68.8352 26.5041,100.182 17.8348,31.1577 41.5043,54.8272 70.9848,70.6541 -24.6616,13.6773 -44.646,33.4963 -60.0005,59.339 -15.3308,25.9845 -22.9844,53.1736 -22.9844,81.8274l0 17.1734c0,56.15 18.3309,101.339 54.9926,135.497 36.6617,33.9924 85.1582,51.0004 145.844,51.0004 60.4965,0 108.993,-17.008 145.655,-51.0004 36.6617,-34.1577 55.0162,-79.3471 55.0162,-135.497l0 -17.1734c0,-29.3388 -7.84258,-56.8351 -23.3388,-82.4888 -15.3308,-25.6774 -35.8349,-45.3547 -61.1816,-58.6776 30.0002,-15.8269 54.0004,-39.4964 72.0006,-70.6541 18.0001,-31.3467 27.0002,-64.6777 27.0002,-100.182l0 -11.6694c0,-39.8271 -8.83472,-74.5045 -26.8349,-103.985 -17.8348,-29.6695 -42.8271,-52.6776 -75.1659,-68.8352 -32.1499,-16.3466 -69.9927,-24.4963 -113.15,-24.4963zm0 95.6464c34.8192,0 62.8351,10.0158 84.166,30.0002 21.3309,20.1734 31.9845,46.3468 31.9845,79.0164l0 6.82683c0,32.8349 -10.6536,59.339 -31.9845,79.3235 -21.3309,20.008 -49.3468,30.0002 -84.166,30.0002 -34.8428,0 -63.0005,-9.9922 -84.3314,-30.0002 -21.3545,-19.9844 -32.0081,-46.6539 -32.0081,-79.8195l0 -7.34651c0,-32.6459 10.6536,-58.654 32.0081,-78.3313 21.3309,-19.8191 49.4886,-29.6695 84.3314,-29.6695zm0 320.837c30.1656,0 54.6618,9.66149 73.1581,28.8427 18.4962,19.1576 27.827,44.6696 27.827,76.1581l0 6.82683c0,30.3546 -9.33078,54.6855 -27.827,73.0163 -18.4962,18.3309 -42.9925,27.4963 -73.1581,27.4963 -30.3309,0 -54.8508,-9.16543 -73.347,-27.4963 -18.4962,-18.3309 -27.827,-42.8271 -27.827,-73.5124l0 -7.32289c0,-31.1577 9.33078,-56.339 27.827,-75.3313 18.4962,-19.1813 43.0161,-28.6774 73.347,-28.6774z\"/>\r\n   <glyph unicode=\"F\" horiz-adv-x=\"558\" d=\"M87.8275 0l0 709.99 99.6622 0 0 -709.99 -99.6622 0zm48.8508 298.845l0 94.6543 344.318 0 0 -94.6543 -344.318 0zm0 316.325l0 94.8196 397.987 0 0 -94.8196 -397.987 0z\"/>\r\n   <glyph unicode=\"5\" horiz-adv-x=\"544\" d=\"M271.49 -7.32289c-54.0004,0 -98.3157,15.4962 -132.993,46.6539 -34.6538,30.9924 -56.5044,75.0006 -65.1737,131.505l0 0.496067 99.5205 0 0 -0.496067c3.66145,-26.0081 13.9844,-46.1578 31.3231,-60.6619 17.1734,-14.5041 39.6617,-21.8506 67.3234,-21.8506 31.8428,0 56.5044,10.6772 74.0085,32.0081 17.3387,21.3309 26.0081,51.3311 26.0081,90.1661l0 59.5044c0,38.835 -8.66936,68.6698 -26.0081,89.8354 -17.5041,21.1655 -42.1657,31.8191 -74.0085,31.8191 -17.3151,0 -33.827,-4.98429 -49.8193,-14.6458 -16.0159,-9.85047 -30.0002,-23.5041 -42.0003,-41.0082l-90.8275 0 0 373.987 361.822 0 0 -94.8196 -262.16 0 0 -159.663c12.3308,10.1576 26.1498,18.0001 41.5043,23.5041 15.3308,5.48036 30.827,8.31503 46.8193,8.31503 61.843,0 109.678,-18.9923 143.505,-56.8351 33.9924,-37.9846 50.835,-91.4889 50.835,-160.489l0 -59.5044c0,-69.3313 -17.3387,-123.001 -52.1579,-161.009 -34.8428,-37.8192 -84.0007,-56.8115 -147.521,-56.8115z\"/>\r\n   <glyph unicode=\"C\" horiz-adv-x=\"618\" d=\"M320.341 -7.32289c-49.5122,0 -92.8354,10.9843 -129.851,33.0003 -37.1578,21.9923 -66.0005,52.8193 -86.481,92.481 -20.5041,39.6854 -30.6853,86.1739 -30.6853,139.182l0 194.836c0,53.3154 10.1812,99.9929 30.6853,139.655 20.4805,39.6617 49.3232,70.5124 86.481,92.5047 37.016,21.9923 80.3392,33.0003 129.851,33.0003 40.9846,0 78.4967,-8.83472 112.489,-26.5041 33.9924,-17.5041 62.5044,-42.0003 85.5125,-73.6541 22.9844,-31.5121 38.4806,-68.5045 46.6539,-110.836l0 0 -102.166 0 0 0c-6.1654,22.8191 -16.4883,42.6618 -30.9924,59.8351 -14.5041,17.1497 -31.5121,30.3309 -51.0004,39.8271 -19.512,9.33078 -39.6617,14.1733 -60.4965,14.1733 -43.6775,0 -78.6857,-15.5198 -105.166,-46.1815 -26.6695,-30.827 -39.8507,-71.3391 -39.8507,-121.82l0 -194.836c0,-50.5043 13.1812,-91.0165 39.8507,-121.678 26.4805,-30.4963 61.4887,-45.8271 105.166,-45.8271 30.827,0 60.0005,9.82685 87.3314,29.3388 27.3309,19.4883 45.8271,47.6697 55.1579,84.4967l0 0 102.166 0 0 0c-8.17329,-42.331 -23.8348,-79.3471 -47.0082,-110.836 -22.9844,-31.6774 -51.4965,-56.1737 -85.3235,-73.8431 -33.827,-17.5041 -71.3391,-26.3152 -112.324,-26.3152z\"/>\r\n   <glyph unicode=\"2\" horiz-adv-x=\"516\" d=\"M62.5044 0l0 86.5046 247.49 330.003c14.3387,18.8269 25.512,38.5042 33.4963,58.654 8.00794,20.1734 12.0001,39.1657 12.0001,57.0004l0 1.01576c0,28.3231 -8.31503,50.3154 -24.9923,66.0005 -16.4883,15.6615 -40.1578,23.3151 -70.6541,23.3151 -28.6774,0 -52.0162,-8.504 -70.1817,-25.4884 -18.0001,-17.1734 -28.9845,-41.3389 -33.0003,-72.4966l0 -0.519689 -102.993 0 0 0.519689c8.83472,61.158 31.1577,108.497 66.9927,142.324 35.6696,33.6617 81.8274,50.5043 138.166,50.5043 63.8273,0 113.009,-16.1812 147.828,-48.3311 34.8428,-32.3388 52.3469,-77.8353 52.3469,-136.844l0 -0.496067c0,-24.9923 -5.17327,-51.3311 -15.6615,-78.8274 -10.3465,-27.4963 -24.8506,-53.6697 -43.5122,-78.8274l-205.49 -279.333 268.49 0 0 -94.6779 -400.326 0z\"/>\r\n   <glyph unicode=\"K\" horiz-adv-x=\"641\" d=\"M151.336 162.178l14.6694 149.316 313.479 398.519 122.529 0 -450.677 -547.835zm-63.4966 -162.178l0 710.013 99.674 0 0 -710.013 -99.674 0zm422.011 0l-225.675 378.818 78.662 72.851 269.01 -451.669 -121.997 0z\"/>\r\n   <glyph unicode=\"7\" horiz-adv-x=\"503\" d=\"M440.011 709.99l0 -88.8196 -183.686 -621.17 -105.993 0 183.663 615.17 -180.663 0 0 -102.001 -99.6622 0 0 196.82 386.342 0z\"/>\r\n   <glyph unicode=\"E\" horiz-adv-x=\"597\" d=\"M87.8275 0l0 709.99 99.6622 0 0 -709.99 -99.6622 0zm48.3311 0l0 94.6779 407.838 0 0 -94.6779 -407.838 0zm0 305.176l0 94.6543 354.003 0 0 -94.6543 -354.003 0zm0 309.995l0 94.8196 407.838 0 0 -94.8196 -407.838 0z\"/>\r\n   <glyph unicode=\"4\" horiz-adv-x=\"568\" d=\"M63.4966 108.828l0 86.5046 238.348 514.162 102.497 0 -232.514 -508.327 348.168 0 0 -92.3393 -456.5 0zm306.168 -109.324l0 417.995 97.1582 0 0 -417.995 -97.1582 0z\"/>\r\n   <glyph unicode=\"S\" horiz-adv-x=\"615\" d=\"M301.325 -7.3347c-34.4766,0 -67.0045,3.33073 -97.4771,9.85047 -30.3309,6.4843 -58.8548,16.1576 -85.5007,29.1616 -26.5041,13.1458 -51.3429,29.3388 -74.3392,48.8272l0 0 62.0084 76.1463 0 0c27.0002,-23.3151 56.7997,-40.9964 89.3275,-52.654 32.4924,-11.6576 67.8194,-17.5041 105.981,-17.5041 51.3429,0 91.17,9.49614 119.517,28.6656 28.3112,19.3466 42.4846,46.1697 42.4846,80.6817l0 0.496067c0,27.0002 -7.15754,47.6579 -21.508,62.0084 -14.3151,14.3151 -32.9884,24.9805 -56.3036,31.9963 -23.3506,6.98037 -48.6854,12.6497 -76.5006,17.3269 -26.6813,4.50004 -53.5044,9.81504 -80.6817,16.0159 -27.1774,6.30714 -52.1579,15.9804 -75.0124,29.1616 -22.8191,13.1458 -41.1381,32.138 -54.9926,56.8351 -13.819,24.6616 -20.6576,57.8272 -20.6576,99.1425l0 0.496067c0,66.0123 22.0041,117.178 65.8352,153.497 44.0082,36.3546 105.981,54.5319 186.167,54.5319 37.9846,0 75.3313,-6.1654 111.65,-18.3545 36.4964,-12.1536 72.0006,-30.827 106.513,-55.9847l0 0 -56.6579 -79.0164 0 0c-27.0002,20.1616 -53.8587,35.1853 -80.8589,44.8232 -26.823,9.85047 -53.6461,14.6694 -80.6463,14.6694 -48.5083,0 -86.3511,-9.63787 -113.174,-28.9845 -26.823,-19.3466 -40.1814,-46.8429 -40.1814,-82.3471l0 -0.496067c0,-26.6459 7.68904,-46.9846 23.3506,-60.9808 15.6615,-13.9962 36.1775,-24.3427 61.3351,-31.0042 25.1577,-6.66147 52.3351,-13.004 81.3195,-18.8505 26.0081,-5.13784 52.0162,-11.4804 78.0242,-18.8151 26.1498,-7.15754 49.8193,-17.823 71.1502,-31.6774 21.3309,-13.819 38.3389,-32.8467 51.1658,-56.8351 13.004,-24.1655 19.3466,-55.4886 19.3466,-94.3236l0 -0.8504c0,-65.4808 -22.8545,-116.151 -68.3509,-151.974 -45.4964,-35.8586 -109.666,-53.6815 -192.332,-53.6815z\"/>\r\n   <glyph unicode=\"1\" horiz-adv-x=\"332\" d=\"M244.655 709.99l0 -709.99 -99.6622 0 0 601.493 -100.985 -61.9847 0 102.993 100.985 67.4887 99.6622 0z\"/>\r\n   <glyph unicode=\"B\" horiz-adv-x=\"645\" d=\"M146.505 0l0 92.3393 192.332 0c52.8193,0 90.1661,9.9922 112.158,30.1656 21.8269,20.1734 32.8349,46.8193 32.8349,79.6542l0 1.51182c0,35.1735 -9.33078,63.1659 -27.9923,84.166 -18.6616,21.0002 -49.5122,31.4884 -92.5047,31.4884l-216.828 0 0 89.8354 216.828 0c36.6617,0 64.4887,8.66936 83.1739,26.1734 18.8269,17.3387 28.1577,42.8271 28.1577,76.3234l0 0c0,35.5042 -10.4883,62.0084 -31.3231,79.6778 -20.8348,17.5041 -52.0162,26.3388 -93.6858,26.3388l-203.151 0 0 92.3157 221.151 0c70.0163,0 122.009,-17.4805 156.332,-52.3232 34.1814,-34.8428 51.1894,-81.4967 51.1894,-140.174l0 0c0,-35.3152 -10.3465,-67.8194 -31.1813,-97.3236 -20.8348,-29.5042 -53.6697,-48.3311 -98.174,-56.339 43.8429,-6.49611 78.0006,-26.0081 102.355,-58.1579 24.1655,-32.1735 36.331,-69.1659 36.331,-110.836l0 -1.51182c0,-57.8272 -18.6852,-104.646 -56.1737,-140.151 -37.5121,-35.5042 -88.1582,-53.1736 -152.34,-53.1736l-229.49 0zm-58.6776 0l0 709.99 99.1661 0 0 -709.99 -99.1661 0z\"/>\r\n   <glyph unicode=\"9\" horiz-adv-x=\"513\" d=\"M146.009 0l178.655 352.491 -0.496067 -17.4805c-8.33865,-15.3545 -21.0002,-26.3388 -37.5121,-33.1656 -16.6537,-6.85045 -35.8113,-10.3465 -57.6619,-10.3465 -51.1658,0 -92.3157,18.9923 -123.497,56.8351 -31.3231,38.0082 -46.8193,88.3235 -46.8193,151.159l0 0.519689c0,68.9769 17.3151,122.481 51.9925,160.324 34.6538,38.0082 83.3392,57.0004 146.174,57.0004 62.8115,0 111.497,-19.1813 145.985,-57.4965 34.5121,-38.1735 51.8272,-92.3393 51.8272,-162.332l0 -0.496067c0,-28.8427 -4.32287,-60.1895 -12.8269,-94.0165 -8.33865,-33.6617 -20.8348,-66.4966 -36.9924,-98.8354l-151.348 -304.16 -107.481 0zm110.836 382.326c31.3231,0 55.4886,10.5119 72.4966,31.6774 17.1497,21.1655 25.6537,51.0004 25.6537,89.5046l0 0.330711c0,37.4885 -8.504,66.4966 -25.6537,87.0007 -17.008,20.5041 -41.1736,30.6617 -72.4966,30.6617 -31.5121,0 -55.843,-10.1576 -73.0163,-30.6617 -17.1497,-20.5041 -25.6537,-49.6776 -25.6537,-87.3314l0 -0.519689c0,-38.4806 8.504,-68.1501 25.6537,-89.1503 17.1734,-21.0002 41.5043,-31.5121 73.0163,-31.5121z\"/>\r\n   <glyph unicode=\"G\" horiz-adv-x=\"646\" d=\"M327.168 382.326l246.167 0 0 -123.993c0,-53.5044 -10.5119,-99.9929 -31.1577,-140.009 -20.6695,-39.8271 -49.5122,-70.6541 -86.67,-92.6464 -37.016,-22.0159 -80.6699,-33.0003 -130.844,-33.0003 -50.339,0 -94.4889,10.3229 -132.332,30.9924 -37.6538,20.6695 -66.9927,49.8193 -87.8275,87.4968 -20.8348,37.5121 -31.1813,81.3313 -31.1813,131.505l0 209.506c0,53.3154 10.3465,99.9929 31.016,139.655 20.6695,39.6617 49.4886,70.5124 86.5046,92.5047 37.1578,21.9923 80.8117,33.0003 130.985,33.0003 41.3389,0 78.9927,-8.83472 113.009,-26.5041 33.9924,-17.5041 62.5044,-42.0003 85.6542,-73.6541 23.1734,-31.5121 38.6696,-68.5045 46.8429,-110.836l0 0 -107.835 0 0 0c-9.16543,36.8271 -26.8349,64.9848 -53.1736,84.4967 -26.5041,19.4883 -54.6618,29.3388 -84.4967,29.3388 -44.3389,0 -79.8195,-15.5198 -106.489,-46.1815 -26.6695,-30.827 -40.0161,-71.3391 -40.0161,-121.82l0 -209.506c0,-46.1815 13.6773,-83.1739 41.0082,-111.001 27.3309,-27.827 63.4966,-41.835 108.332,-41.835 44.3389,0 79.8431,14.6694 106.513,44.0082 26.6459,29.3152 39.9924,70.158 39.9924,122.481l0 30.8506 -144.001 0 0 95.1504z\"/>\r\n   <glyph unicode=\"6\" horiz-adv-x=\"513\" d=\"M256.325 -7.32289c-62.8351,0 -111.497,18.6616 -145.985,56.15 -34.5121,37.5121 -51.6618,90.1661 -51.6618,158.174l0 0.496067c0,30.6617 4.15751,63.1659 12.6615,97.5126 8.504,34.3231 20.6695,67.3234 36.4964,99.3315l154.324 305.648 107.505 0 -181.159 -353.979 0.496067 17.4805c16.8427,32.3388 47.0082,48.3311 90.3314,48.3311 55.6776,0 98.8354,-18.4962 129.332,-55.3233 30.6617,-36.9924 45.9925,-89.1739 45.9925,-156.497l0 -0.496067c0,-68.6698 -17.3151,-122.009 -51.8272,-160.017 -34.4885,-37.8192 -83.3392,-56.8115 -146.505,-56.8115zm0 95.6464c32.0081,0 56.339,9.85047 73.347,29.3388 16.819,19.512 25.323,47.339 25.323,83.5046l0 0.496067c0,39.6617 -9.00007,70.347 -26.8349,92.0086 -18.0001,21.6616 -43.4885,32.5042 -76.6541,32.5042 -29.6695,0 -52.6776,-10.8426 -68.8352,-32.6695 -16.3466,-21.8506 -24.4963,-52.6776 -24.4963,-92.3393l0 -0.496067c0,-36.1656 8.504,-63.8273 25.6537,-83.1739 17.1734,-19.4883 41.3389,-29.1735 72.4966,-29.1735z\"/>\r\n  </font>\r\n  <style type=\"text/css\">\r\n   <![CDATA[\r\n    @font-face { font-family:\"Bahnschrift\";font-variant:normal;font-style:normal;font-weight:normal;src:url(\"#FontID0\") format(svg)}\r\n    .fil6_3 {fill:#332C2B}\r\n    .fil5_3 {fill:#EEEEEF;fill-rule:nonzero}\r\n    .fil1_3 {fill:#EBECEC;fill-rule:nonzero}\r\n    .fil3_3 {fill:#FFF000;fill-rule:nonzero}\r\n    .fil2_3 {fill:#B3DAB9;fill-rule:nonzero}\r\n    .fil0_3 {fill:black;fill-rule:nonzero}\r\n    .fil4_3 {fill:#FF3F00;fill-rule:nonzero}\r\n    .fnt1_3 {font-weight:normal;font-size:282.22px;font-family:\'Bahnschrift\'}\r\n    .fnt0_3 {font-weight:normal;font-size:423.33px;font-family:\'Bahnschrift\'}\r\n   ]]>\r\n  </style>\r\n </defs>\r\n <g id=\"Layer_x0020_1\">\r\n  <metadata id=\"CorelCorpID_0Corel-Layer\"/>\r\n  <path class=\"fil0_3\" d=\"M36013 3143c3,0 6,2 9,3 3,2 5,5 7,7l208 137c12,8 16,24 8,37l-2585 3698 14 10c3,0 5,2 8,3 2,2 4,4 6,6l1416 999c11,9 14,25 6,37l-1195 1722c-1,3 -2,6 -4,9 -2,2 -4,4 -6,6l-2389 3442c-1,2 -2,4 -3,5 -1,1 -2,3 -3,4l-6708 9665 5022 2908c13,7 17,23 10,36l-1866 2856 786 425c13,6 18,22 11,35l-841 1466 -818 1428c-7,13 -24,17 -36,10l-5815 -3414c-3,-1 -6,-2 -8,-4 -3,-1 -5,-3 -7,-5l-6329 -3717c-4,-1 -8,-2 -11,-4 -4,-2 -6,-4 -8,-8l-12385 -7272c-12,-7 -16,-22 -10,-35l1458 -2932 1666 -2849c8,-13 24,-17 36,-9l2617 1526c6,-1 13,0 18,3l1786 1049 1294 -2374 1 -3 451 -651 372 -959c1,-1 1,-3 2,-4l1321 -2190c8,-12 24,-16 36,-9l410 266 2613 -4091c8,-12 24,-16 37,-8 1,1 2,2 4,3l7164 6827 3661 3132 7773 -11714c8,-12 24,-15 37,-7l759 499z\"/>\r\n  <path class=\"fil1_3\" d=\"M26372 15999c-8,12 -25,15 -37,7 -1,-1 -3,-2 -4,-4l-3246 -3094c-5,-1 -9,-3 -12,-6 -4,-3 -6,-8 -7,-12l-742 -707c-5,-1 -9,-3 -12,-6 -4,-4 -6,-8 -8,-12l-741 -707c-4,-1 -9,-3 -12,-6 -4,-4 -6,-8 -8,-13l-741 -706c-4,-1 -9,-3 -12,-7 -4,-3 -7,-7 -8,-12l-740 -706c-5,-1 -10,-3 -14,-7 -3,-3 -6,-8 -7,-12l-740 -706c-5,-1 -10,-3 -14,-7 -3,-4 -6,-8 -7,-13l-740 -705c-5,-1 -10,-3 -14,-7 -4,-4 -6,-8 -7,-13l-740 -705c-5,-1 -10,-4 -14,-7 -4,-4 -6,-9 -7,-14l-740 -705c-5,0 -10,-3 -14,-6 -4,-4 -6,-9 -7,-14l-740 -705c-5,0 -10,-3 -14,-7 -4,-3 -6,-8 -7,-13l-419 -399 -174 180 -7084 12065 0 1c-8,13 -24,17 -36,10l-460 -266 -1816 -1070c-13,-7 -17,-23 -10,-36l629 -1066c0,-4 1,-8 3,-11 2,-3 5,-6 8,-8l291 -494c0,-3 1,-5 3,-8 1,-2 3,-4 5,-6l294 -500c1,-1 1,-2 2,-4 1,-1 2,-2 3,-3l260 -442c1,-2 1,-5 3,-7 1,-2 3,-4 4,-6l258 -437c1,-3 2,-6 3,-9 2,-3 4,-6 7,-8l250 -423 -2586 -1509 -1652 2827 -1447 2907 2382 1398 813 -1394 0 0 1 0c7,-13 23,-17 36,-9l2709 1590c4,0 8,1 12,3 3,3 6,6 9,9l884 519c4,1 8,2 11,4 4,2 7,5 9,8l886 520c6,-1 12,0 17,3 6,3 10,8 12,14l2698 1584c4,0 8,1 11,3 4,2 7,5 9,8l886 520c3,0 7,2 10,3 3,2 6,5 8,8l887 520c3,1 7,2 10,4 3,2 5,4 7,7l888 521c3,0 6,1 9,3 3,2 6,4 8,6l888 522c6,-1 11,0 16,3 5,3 9,8 11,13l3607 2117c3,0 5,1 8,3 3,1 5,3 7,5l890 523c3,1 5,2 8,3 2,1 4,3 6,5l892 524c2,0 4,1 6,2 2,2 4,3 6,5l893 524c2,1 4,2 6,3 2,1 3,2 5,3l3841 2255c3,0 6,2 9,3 3,2 6,4 8,7l1018 597 813 -1418 -789 -426c-13,-8 -16,-24 -8,-37l1866 -2855 -5022 -2908 -2 -1 -1058 -621c-4,0 -8,-1 -11,-3 -4,-2 -7,-5 -9,-8l-886 -520c-3,-1 -7,-2 -10,-4 -3,-2 -6,-4 -8,-7l-954 -560c-13,-7 -17,-23 -9,-36l1658 -2836c7,-12 24,-17 36,-9l959 563c4,1 7,2 10,4 4,2 6,4 8,7l886 521c4,0 8,1 11,3 3,2 6,5 8,8l1252 736 624 -899 -1410 -985c-12,-8 -15,-25 -6,-37l2395 -3449c1,-2 2,-3 3,-4 1,-2 2,-3 3,-4l1787 -2573c0,-5 1,-11 5,-15 3,-5 7,-8 12,-10l587 -845c1,-3 2,-5 4,-7 1,-2 3,-3 5,-5l586 -844c1,-5 2,-9 5,-12 2,-4 5,-7 9,-9l1185 -1705c0,-6 1,-12 5,-17 3,-5 8,-8 13,-10l586 -843c1,-3 2,-6 4,-8 1,-3 4,-5 6,-7l588 -847 -21 -14 0 0 -120 -78 -1 -1c-12,-8 -15,-24 -7,-36l2490 -3761 -723 -475 -7775 11716 -1 2 -1099 1579z\"/>\r\n  <path class=\"fil0_3\" d=\"M9178 18621c-13,-8 -17,-24 -10,-36l1096 -1866c0,-3 1,-6 3,-8 1,-3 3,-5 5,-7l523 -891c1,-2 2,-5 3,-7 1,-2 3,-5 5,-6l3187 -5429c0,-2 1,-5 3,-7 1,-3 3,-5 5,-7l1825 -3108 1 -1c7,-13 23,-17 36,-10l546 323c2,2 4,3 5,5l751 715c2,1 3,3 4,4l1219 1161c9,9 11,23 4,34l-2574 4380c0,4 -1,8 -3,13 -3,4 -6,7 -10,9l-2120 3608c0,3 -1,6 -3,8 -1,3 -3,5 -5,7l-523 889c0,3 -1,6 -3,9 -1,3 -3,5 -6,7l-522 889c0,3 -2,6 -3,9 -2,2 -4,5 -6,7l-561 955c-8,12 -24,16 -36,9l-1407 -823c-3,0 -5,-1 -8,-3 -2,-1 -4,-3 -6,-5l-1415 -827zm15768 -570l-54 54c-2,2 -4,4 -6,5l-64 43 -1 0c-2,2 -6,3 -9,4l-79 14c-2,1 -5,1 -7,1l-78 -7c-3,0 -6,-1 -9,-2l-71 -28c-1,-1 -3,-2 -4,-3l-459 -272c-1,0 -2,-1 -4,-2l-64 -51c-3,-2 -5,-4 -7,-7l-43 -72c-1,-2 -2,-4 -3,-6l-20 -77c-2,-3 -2,-6 -2,-9l0 -79c0,-4 1,-8 2,-11l36 -78c0,-1 1,-2 1,-4l819 -1400c1,-2 3,-4 4,-5l48 -54c1,-3 4,-5 6,-7l65 -43c2,-1 5,-2 7,-3l70 -21c3,-1 6,-2 9,-2l79 0c3,0 5,1 7,1l77 21c4,1 7,2 10,4l65 43c2,2 3,3 5,5l479 465c2,1 3,3 4,4l42 57c1,1 2,3 3,5l28 63c2,3 3,6 3,10l7 76c1,4 1,7 0,10l-14 72 0 0c-1,2 -1,4 -2,5l-28 63c-1,2 -2,4 -3,7l-840 1206c-2,2 -3,3 -5,5zm-3544 3829c8,-13 24,-17 37,-9l910 535c3,0 6,1 9,3 2,2 5,4 7,6l876 515c2,1 5,2 7,3 2,1 4,3 6,5l880 517c1,1 3,2 4,2 1,1 3,2 4,3l1760 1035c6,-1 12,0 17,3 5,3 9,8 11,13l865 509c2,0 4,1 7,3 2,1 4,3 6,5l879 516c2,1 3,2 5,3 2,1 3,2 5,3l885 521c13,7 17,23 10,36l-1695 2886c-7,13 -23,17 -36,10l-2661 -1562c-3,-1 -6,-2 -10,-4 -3,-2 -5,-4 -7,-7l-4466 -2620c-12,-8 -16,-24 -9,-37l844 -1441c0,-3 2,-6 3,-9 2,-3 4,-5 7,-7l840 -1436zm-5205 826l2158 -3676c1,-3 2,-5 3,-8 2,-2 3,-4 5,-6l524 -891c0,-3 1,-5 3,-7 1,-2 2,-4 4,-6l524 -893c1,-2 2,-4 3,-6 1,-2 2,-4 4,-5l525 -894c0,-2 1,-4 2,-5 1,-2 3,-4 4,-5l1999 -3405c1,-2 2,-4 4,-6 10,-10 27,-11 37,-1l2449 2327c9,9 10,23 3,33l-2674 4548c0,4 -1,7 -3,10 -2,3 -4,6 -7,8l-521 886c0,4 -1,7 -3,11 -2,3 -5,6 -8,8l-1059 1802c-1,2 -2,4 -3,6 -1,2 -3,4 -4,6l-524 891c-1,3 -2,5 -3,8 -2,3 -4,5 -6,7l-562 955c-7,13 -23,17 -36,9l-1413 -832 -1 0 -1 -1 -1413 -832c-13,-8 -17,-24 -10,-36zm-3511 -2061l557 -948c0,-5 1,-10 3,-14 3,-4 6,-8 11,-10l1057 -1802c0,-1 1,-3 2,-4 1,-2 2,-3 3,-5l527 -899 1 -1 1 -2 1590 -2708c0,-4 1,-8 3,-11 2,-4 5,-6 8,-9l520 -886c1,-3 2,-7 4,-10 1,-3 4,-6 6,-8l1946 -3315c1,-2 2,-4 4,-6 10,-11 27,-11 37,-1l1218 1157c2,1 4,2 5,3 6,3 9,7 11,13l1215 1153c9,9 10,23 4,34l-5858 9971c-8,13 -24,17 -37,10l-2828 -1666c-13,-7 -17,-23 -10,-36z\"/>\r\n  <path class=\"fil0_3\" d=\"M3149 16500c2,-7 7,-11 12,-14l1871 -3451c1,-1 2,-3 3,-4l56 -77c1,-2 3,-4 5,-6l79 -64c2,-2 4,-3 6,-4l92 -42c3,-2 5,-3 8,-3l100 -14c3,-1 6,-1 8,0l101 14c2,0 4,1 5,2l92 35c2,0 4,1 6,2l1113 646c3,3 6,5 8,9l64 42c3,2 6,5 8,8l57 85c1,1 2,3 2,5l43 92c1,3 2,5 3,8l14 100c0,3 0,6 0,8l-14 101c-1,2 -1,4 -2,6l-34 80c-1,3 -2,7 -4,10l-2 4 -3 7c-2,4 -4,7 -7,9l-1998 3390 0 0 0 0 0 1 0 0 -1 0 0 0 0 1 0 0 0 0 -1 0 0 1 0 0 -63 84c-2,3 -4,5 -7,7l-79 58c-1,1 -3,2 -5,2l-99 43c-3,1 -6,2 -10,3l-100 7c-2,0 -4,0 -6,0l-101 -15c-1,0 -3,-1 -5,-1l-93 -36c-1,0 -3,-1 -4,-2l-970 -567c-6,-4 -10,-9 -12,-15l-54 -36c-2,-2 -4,-4 -6,-6l-64 -85c-1,-2 -3,-4 -4,-6l-43 -94c-1,-2 -2,-5 -2,-7l-14 -106c-1,-3 -1,-6 0,-9l14 -99c0,-3 1,-5 1,-7l36 -100z\"/>\r\n  <path class=\"fil2_3\" d=\"M36014 3206l-2476 3739 79 50 2569 -3676 -172 -113zm-11425 14880l66 26 72 7 70 -13 58 -39 53 -53 838 -1203 26 -59 13 -66 -6 -70 -26 -58 -40 -53 -477 -464 -60 -40 -71 -19 -72 0 -64 19 -59 40 -45 52 -817 1397 -33 72 0 71 19 71 39 65 60 46 456 271zm-21399 -1542l-26 72 -13 94 13 100 40 87 60 80 83 55c4,3 7,7 9,11l935 547 89 34 95 14 93 -7 94 -40 73 -53 61 -82 2005 -3401 38 -88 13 -93 -13 -93 -41 -89 -53 -79 -82 -55c-1,-1 -3,-2 -4,-4l-1091 -633 -88 -34 -94 -13 -93 13 -87 40 -74 60 -54 75 -1888 3481 0 1zm14148 -11378l-733 -700 -2610 4087c-8,13 -25,16 -37,8l-408 -265 -1306 2165 -372 959c-1,2 -2,4 -3,6l-452 652 -1306 2398c-2,3 -5,6 -8,8l-1992 3446c132,77 263,153 395,230l7073 -12046c1,-2 3,-4 4,-6l194 -201 0 0 0 0 1 0 0 0 0 -1 1 0 0 0 0 -1 0 0 1 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 1 0 0 0 0 -1 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 -1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 -1 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 0 1 1 0 0 0 0 0 0 430 410 1094 -1150z\"/>\r\n  <path class=\"fil3_3\" d=\"M8065 17903l5 -8 -1786 -1057 -8 13 13 8 35 20 1426 840c105,62 210,123 315,184zm-519 839l6 -10 -1769 -1039 -6 10 1769 1039z\"/>\r\n  <path class=\"fil4_3\" d=\"M649 18825c-7,13 -23,18 -36,12 -13,-7 -18,-23 -11,-36l1529 -2972 1 -2 4867 -8751c8,-13 24,-17 36,-10 13,7 18,23 11,35l-4868 8752 0 0 -1529 2972zm32228 -17716c-12,-8 -16,-24 -8,-37 8,-12 24,-16 36,-8l5988 3777c13,7 16,24 9,36 -8,12 -24,16 -37,8l-5988 -3776zm488 -776c-12,-8 -16,-24 -8,-36 8,-12 24,-16 37,-8l5995 3769c12,8 16,24 8,36 -8,13 -24,16 -36,9l-5996 -3770zm-25468 7224c7,-13 23,-17 36,-10 13,7 17,23 10,36 -365,649 -731,1297 -1098,1945 -968,1793 -1906,3442 -2937,5205 -764,1537 -1511,3031 -2312,4545 -6,13 -22,18 -35,11 -13,-7 -18,-23 -11,-36 798,-1510 1522,-3042 2312,-4546l1666 -2850c783,-1452 1562,-2866 2369,-4300z\"/>', '<g id=\"_2096257672224\">\r\n   <polygon class=\"fil5_3\" points=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"16250\"  class=\"fil6_3 fnt0_3\">[[4]]</text>\r\n   </g>\r\n  </g>', '<g id=\"_2096257673024\">\r\n   <path class=\"fil5_3\" d=\"[[1]]\" style=\"fill:[[2]]\"/>\r\n   <g transform=\"[[3]]\">\r\n    <text x=\"20000\" y=\"16250\"  class=\"fil6_3 fnt0_3\">[[4]]</text>\r\n   </g>\r\n  </g>', '', ' </g>\r\n</svg>', 400, 100, 100);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int NOT NULL,
  `lihat` int NOT NULL,
  `tambah` int NOT NULL,
  `edit` int NOT NULL,
  `hapus` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu`
--

-- --------------------------------------------------------

--
-- Table structure for table `menu_panduan_aplikasi`
--

CREATE TABLE `menu_panduan_aplikasi` (
  `id` int NOT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_yt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metode_bayar`
--

CREATE TABLE `metode_bayar` (
  `id` int NOT NULL,
  `jenis_bayar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `metode_bayar`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

-- --------------------------------------------------------

--
-- Table structure for table `mutasi_saldo`
--

CREATE TABLE `mutasi_saldo` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `rekening_asal` int NOT NULL,
  `rekening_tujuan` int NOT NULL,
  `nominal` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notaris`
--

CREATE TABLE `notaris` (
  `id` int NOT NULL,
  `nama_notaris` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat_notaris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp_notaris` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan_notaris` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pemasukan`
--

CREATE TABLE `pemasukan` (
  `id` int NOT NULL,
  `id_hutang` int NOT NULL DEFAULT '0',
  `id_bank` int NOT NULL DEFAULT '0',
  `id_metode_bayar` int DEFAULT '1',
  `id_piutang` int NOT NULL DEFAULT '0',
  `id_mutasi` int NOT NULL DEFAULT '0',
  `id_customer` int NOT NULL DEFAULT '0',
  `id_lokasi` int NOT NULL DEFAULT '0',
  `id_pindah_unit` int NOT NULL DEFAULT '0',
  `id_ganti_nama` int NOT NULL DEFAULT '0',
  `no_kwitansi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal` date NOT NULL,
  `nominal` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_kategori_transaksi` int NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pemasukan`
--

-- --------------------------------------------------------

--
-- Table structure for table `pemasukan_retensi`
--

CREATE TABLE `pemasukan_retensi` (
  `id` bigint UNSIGNED NOT NULL,
  `id_pemasukan` bigint UNSIGNED NOT NULL,
  `id_retensi` bigint UNSIGNED NOT NULL,
  `nominal` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pemasukan_retensi`
--

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_cancel`
--

CREATE TABLE `pembelian_cancel` (
  `id` int NOT NULL,
  `tgl_batal` date NOT NULL,
  `id_customer` int NOT NULL,
  `keterangan_batal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `biaya_admin` bigint NOT NULL,
  `jumlah_bayar` bigint NOT NULL,
  `id_bank` int NOT NULL,
  `id_bank_tujuan` int NOT NULL,
  `no_rekening` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atas_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lampiran_bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengajuan_hold`
--

CREATE TABLE `pengajuan_hold` (
  `id` int NOT NULL,
  `no_registrasi` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_booking` date DEFAULT NULL,
  `nama_lengkap` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_ktp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_domisili` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `jenis_kelamin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat_lahir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `npwp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pernikahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik_p` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_bpjs_kes` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_ktp` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_npwp` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_kk` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_bpjs` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_pemohon` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_ktp_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_fee` bigint DEFAULT NULL,
  `file_bukti` varchar(74) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_sppr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_marketing` int NOT NULL,
  `id_freelance` bigint UNSIGNED DEFAULT NULL,
  `id_lokasi` int NOT NULL,
  `id_kavling` int NOT NULL,
  `hrg_jual` bigint NOT NULL,
  `biaya_surat` bigint NOT NULL,
  `peningkatan_mutu` bigint NOT NULL,
  `total_harga` bigint NOT NULL,
  `jenis_perumahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_pembelian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `an_surat_cash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termin_x_cash_b` bigint NOT NULL DEFAULT '0',
  `stt_reg` int NOT NULL COMMENT '1=pending\r\n2=disetujui\r\n3=ditolak'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengajuan_hold`
--

-- --------------------------------------------------------

--
-- Table structure for table `pengajuan_hold_tempo`
--

CREATE TABLE `pengajuan_hold_tempo` (
  `id` int NOT NULL,
  `no_registrasi` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_booking` date DEFAULT NULL,
  `nama_lengkap` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_ktp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_domisili` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `jenis_kelamin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat_lahir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `npwp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pernikahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik_p` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_bpjs_kes` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp_saudara` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_ktp` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_npwp` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_kk` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_bpjs` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_pemohon` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_ktp_p` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_fee` bigint DEFAULT NULL,
  `file_bukti` varchar(74) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_marketing` int NOT NULL,
  `id_freelance` bigint UNSIGNED DEFAULT NULL,
  `id_lokasi` int NOT NULL,
  `id_kavling` int NOT NULL,
  `hrg_jual` bigint NOT NULL,
  `biaya_surat` bigint NOT NULL,
  `peningkatan_mutu` bigint NOT NULL,
  `total_harga` bigint NOT NULL,
  `jenis_perumahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_pembelian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `an_surat_cash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termin_x_cash_b` bigint NOT NULL DEFAULT '0',
  `stt_reg` int NOT NULL COMMENT '1=pending\r\n2=disetujui\r\n3=ditolak',
  `id_pengajuan_hold` int NOT NULL,
  `id_user` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` int NOT NULL,
  `id_hutang` int NOT NULL DEFAULT '0',
  `id_piutang` int NOT NULL DEFAULT '0',
  `id_po` int NOT NULL DEFAULT '0',
  `id_mutasi` int NOT NULL DEFAULT '0',
  `id_proyek_bangunan_detail` int NOT NULL DEFAULT '0',
  `id_proyek_jalan_detail` int NOT NULL DEFAULT '0',
  `id_proyek_saluran_detail` int NOT NULL DEFAULT '0',
  `id_pembelian_cancel` int NOT NULL DEFAULT '0',
  `tanggal` date NOT NULL,
  `id_bank` int NOT NULL DEFAULT '0',
  `nominal` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kategori_transaksi` int NOT NULL,
  `id_metode_bayar` int NOT NULL DEFAULT '1',
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `persyaratan_legal`
--

CREATE TABLE `persyaratan_legal` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `IPH` int DEFAULT '0',
  `SHGB` int DEFAULT '0',
  `SSP` int DEFAULT '0',
  `BPHTB` int DEFAULT '0',
  `SIKUMBANG` int DEFAULT '0',
  `DAFTAR_SIKASEP` int DEFAULT '0',
  `FOTO_SIKASEP` int DEFAULT '0',
  `TRILOGI` int DEFAULT '0',
  `catatan_kekurangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `percakapan_wa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persyaratan_legal`
--

-- --------------------------------------------------------

--
-- Table structure for table `perusahaan`
--

CREATE TABLE `perusahaan` (
  `id` int NOT NULL,
  `nama_perusahaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat_perusahaan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp_perusahaan` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bg_kwitansi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kop_surat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kota_penandatangan` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_penandatangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jabatan_penandatangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_mengetahui` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `perusahaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `pindah_unit`
--

CREATE TABLE `pindah_unit` (
  `id` int NOT NULL,
  `tgl_pindah` date NOT NULL,
  `id_customer` int NOT NULL,
  `id_kavling_lama` int NOT NULL,
  `id_kavling_baru` int NOT NULL,
  `nominal_utj` int NOT NULL,
  `biaya_admin` int NOT NULL,
  `keterangan_pindah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_bank` int NOT NULL,
  `id_metode_bayar` int NOT NULL,
  `lampiran_bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `piutang`
--

CREATE TABLE `piutang` (
  `id` int NOT NULL,
  `id_bank` int NOT NULL DEFAULT '0',
  `id_customer` int NOT NULL DEFAULT '0',
  `tanggal_piutang` date NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` int NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `terbayar` int NOT NULL,
  `sisa_bayar` int NOT NULL,
  `tgl_pelunasan` date DEFAULT NULL,
  `id_kategori_transaksi` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `piutang`
--

-- --------------------------------------------------------

--
-- Table structure for table `ppjb`
--

CREATE TABLE `ppjb` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `tanggal_ppjb` date NOT NULL,
  `no_ppjb` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `termin` int NOT NULL DEFAULT '0',
  `sisa_bayar` bigint NOT NULL DEFAULT '0',
  `acc_plafon` bigint NOT NULL DEFAULT '0',
  `bayar_per_bulan` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `progres_list_pembangunan`
--

CREATE TABLE `progres_list_pembangunan` (
  `id` int NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warna` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `progres_list_penjualan`
--

CREATE TABLE `progres_list_penjualan` (
  `id` int NOT NULL,
  `status_progres` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `urutan` int NOT NULL,
  `keterangan` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warna` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_tampil` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `progres_unit_ready`
--

CREATE TABLE `progres_unit_ready` (
  `id` int NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warna` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prospek_customer`
--

CREATE TABLE `prospek_customer` (
  `id` int NOT NULL,
  `tgl_terima` date NOT NULL,
  `nama_lengkap` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usia` int NOT NULL,
  `no_telp` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pekerjaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `penghasilan` bigint NOT NULL,
  `sumber_informasi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rangking` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_marketing` int NOT NULL,
  `id_freelance` int NOT NULL,
  `keterangan_belum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_bangunan`
--

CREATE TABLE `proyek_bangunan` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `no_kontrak` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_proyek` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_lokasi` int NOT NULL,
  `nama_pemborong` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_rumah` int NOT NULL,
  `harga_satuan` int NOT NULL,
  `nilai_pekerjaan` bigint NOT NULL,
  `id_bank` int NOT NULL,
  `jumlah_unit` int NOT NULL,
  `volume_pekerjaan` int NOT NULL,
  `id_bayar` int NOT NULL,
  `jumlah_termin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_bangunan_blok`
--

CREATE TABLE `proyek_bangunan_blok` (
  `id` int NOT NULL,
  `id_proyek_bangunan` int NOT NULL,
  `blok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_bangunan_detail`
--

CREATE TABLE `proyek_bangunan_detail` (
  `id` int NOT NULL,
  `id_proyek_bangunan` int NOT NULL,
  `op_ke` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `persen` decimal(5,2) NOT NULL,
  `nilai_pekerjaan` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_bangunan_detail_kerja`
--

CREATE TABLE `proyek_bangunan_detail_kerja` (
  `id` int NOT NULL,
  `id_proyek_bangunan` int NOT NULL,
  `id_proyek_bangunan_detail` int NOT NULL,
  `id_jenis_pekerjaan` int NOT NULL,
  `op_lalu` int NOT NULL,
  `op_sekarang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_bangunan_unit`
--

CREATE TABLE `proyek_bangunan_unit` (
  `id` int NOT NULL,
  `id_proyek_bangunan` int NOT NULL,
  `kode_kavling` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_jalan`
--

CREATE TABLE `proyek_jalan` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `no_kontrak` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_proyek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_lokasi` int NOT NULL,
  `nama_pemborong` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_jalan` int NOT NULL,
  `harga_satuan` int NOT NULL,
  `nilai_pekerjaan` bigint DEFAULT NULL,
  `id_bank` int NOT NULL,
  `id_bayar` int NOT NULL,
  `jumlah_termin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_jalan_detail`
--

CREATE TABLE `proyek_jalan_detail` (
  `id` int NOT NULL,
  `id_proyek_jalan` int NOT NULL,
  `op_ke` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `persen` decimal(5,2) NOT NULL,
  `nilai_pekerjaan` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_jalan_detail_kerja`
--

CREATE TABLE `proyek_jalan_detail_kerja` (
  `id` int NOT NULL,
  `id_proyek_jalan` int NOT NULL,
  `id_proyek_jalan_detail` int NOT NULL,
  `id_jenis_pekerjaan` int NOT NULL,
  `op_lalu` int NOT NULL,
  `op_sekarang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_saluran`
--

CREATE TABLE `proyek_saluran` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `no_kontrak` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_proyek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_lokasi` int NOT NULL,
  `nama_pemborong` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_saluran` int NOT NULL,
  `harga_satuan` int NOT NULL,
  `nilai_pekerjaan` bigint NOT NULL,
  `id_bank` int NOT NULL,
  `id_bayar` int NOT NULL,
  `jumlah_termin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_saluran_detail`
--

CREATE TABLE `proyek_saluran_detail` (
  `id` int NOT NULL,
  `id_proyek_saluran` int NOT NULL,
  `op_ke` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `persen` decimal(5,2) NOT NULL,
  `nilai_pekerjaan` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyek_saluran_detail_kerja`
--

CREATE TABLE `proyek_saluran_detail_kerja` (
  `id` int NOT NULL,
  `id_proyek_saluran` int NOT NULL,
  `id_proyek_saluran_detail` int NOT NULL,
  `id_jenis_pekerjaan` int NOT NULL,
  `op_lalu` int NOT NULL,
  `op_sekarang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rekap_akad`
--

CREATE TABLE `rekap_akad` (
  `id` int NOT NULL,
  `tgl_akad` date NOT NULL,
  `id_customer` int NOT NULL,
  `id_bank` int NOT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `retensi`
--

CREATE TABLE `retensi` (
  `id` bigint UNSIGNED NOT NULL,
  `nama_retensi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `retensi`
--

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `id` int NOT NULL,
  `id_role` int NOT NULL,
  `id_menu` int NOT NULL,
  `lihat` int NOT NULL,
  `beranda` int NOT NULL DEFAULT '0',
  `tambah` int NOT NULL,
  `edit` int NOT NULL,
  `hapus` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

-- --------------------------------------------------------

--
-- Table structure for table `saluran`
--

CREATE TABLE `saluran` (
  `id` int NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_jalan` int NOT NULL,
  `panjang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--

CREATE TABLE `satuan` (
  `id` int NOT NULL,
  `nama_satuan` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `serah_terima_kunci`
--

CREATE TABLE `serah_terima_kunci` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `tgl_serah_terima` date NOT NULL,
  `tgl_expired` date NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0', '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IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6OTp7aTowO3M6OToiaWRfcGFyZW50IjtpOjE7czo1OiJ0aXRsZSI7aToyO3M6MTA6InJvdXRlX25hbWUiO2k6MztzOjQ6Imljb24iO2k6NDtzOjY6InVydXRhbiI7aTo1O3M6NToibGloYXQiO2k6NjtzOjY6InRhbWJhaCI7aTo3O3M6NDoiZWRpdCI7aTo4O3M6NToiaGFwdXMiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjk6ImlkX3BhcmVudCI7aToxO3M6NToidGl0bGUiO2k6MjtzOjEwOiJyb3V0ZV9uYW1lIjtpOjM7czo0OiJpY29uIjtpOjQ7czo2OiJ1cnV0YW4iO2k6NTtzOjU6ImxpaGF0IjtpOjY7czo2OiJ0YW1iYWgiO2k6NztzOjQ6ImVkaXQiO2k6ODtzOjU6ImhhcHVzIjt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX1zOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7fXM6NDoibmFtYSI7czoxNjoiZmFpc2FsIGRhbWFuaWsgQSI7czo2OiJsb2thc2kiO3M6MTk6IkRFIEFMQVNLQSBSRVNJREVOQ0UiO3M6NDoiYmxvayI7czo0OiJCLTA0IjtzOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1783241947);

-- --------------------------------------------------------

--
-- Table structure for table `sppr`
--

CREATE TABLE `sppr` (
  `id` bigint UNSIGNED NOT NULL,
  `id_customer` int NOT NULL,
  `no_sppr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `luas_bangunan` bigint NOT NULL,
  `luas_tanah` bigint NOT NULL,
  `blok` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_jual` bigint NOT NULL,
  `asumsi_plafon_kpr` bigint NOT NULL,
  `biaya_surat_surat` bigint NOT NULL,
  `peningkatan_mutu` bigint NOT NULL,
  `biaya_kelebihan_tanah` bigint DEFAULT NULL,
  `biaya_sudut` bigint DEFAULT NULL,
  `biaya_lain_lain` bigint DEFAULT NULL,
  `total_yang_harus_dibayar` bigint NOT NULL,
  `jumlah_booking_fee` bigint NOT NULL,
  `cicilan_per_bulan` bigint NOT NULL,
  `id_marketing` int DEFAULT NULL,
  `penandatangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spr`
--

CREATE TABLE `spr` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `id_kavling` int NOT NULL,
  `kode_kavling` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_rumah` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `luas_tanah` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_lengkap` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat_rumah` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_keluarga` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hubungan_keluarga` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp_keluarga` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp_keluarga` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_perusahaan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat_kantor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp_kantor` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_spr` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_spr` date NOT NULL,
  `jam_spr` time NOT NULL,
  `harga_rumah` bigint NOT NULL,
  `harga_diskon` int NOT NULL,
  `booking_fee_spr` bigint NOT NULL,
  `nomor_va` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_akad` date NOT NULL,
  `nomor_akad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_akad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan_akad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_ppjb` date NOT NULL,
  `nomor_ppjb` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_ppjb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan_ppjb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_spr` int NOT NULL,
  `stt_akad` int NOT NULL,
  `id_marketing` int NOT NULL,
  `nama_marketing` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stt_keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int NOT NULL,
  `kode` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `template_pesan`
--

CREATE TABLE `template_pesan` (
  `id` int NOT NULL,
  `nama_template` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_pesan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE `throttle` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_file`
--

CREATE TABLE `upload_file` (
  `id` int NOT NULL,
  `tanggal` date NOT NULL,
  `id_customer` int NOT NULL,
  `nama_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `upload_file`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `surname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('AKTIF','BLOKIR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AKTIF',
  `id_role` int NOT NULL DEFAULT '0',
  `id_marketing` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

-- --------------------------------------------------------

--
-- Table structure for table `variable_akad`
--

CREATE TABLE `variable_akad` (
  `id` int NOT NULL,
  `id_jenis` int NOT NULL,
  `jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_var` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wawancara`
--

CREATE TABLE `wawancara` (
  `id` int NOT NULL,
  `tgl_wawancara` date DEFAULT NULL,
  `id_customer` int NOT NULL,
  `catatan_wawancara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_bank_kpr` int NOT NULL,
  `status` int NOT NULL COMMENT '1. Wawancara, 2.SP3K'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wawancara_sp3k`
--

CREATE TABLE `wawancara_sp3k` (
  `id` int NOT NULL,
  `id_wawancara` int NOT NULL,
  `id_bank_kpr` int NOT NULL,
  `acc_plafon` int NOT NULL,
  `tenor` int NOT NULL,
  `id_notaris` int NOT NULL,
  `tgl_terbit_sp3k` date NOT NULL,
  `no_sp3k` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_expired` date DEFAULT NULL,
  `catatan_acc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL COMMENT '1. Ready, 2. Expired',
  `lampiran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aduan`
--
ALTER TABLE `aduan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aduan_proses`
--
ALTER TABLE `aduan_proses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `akad`
--
ALTER TABLE `akad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `balik_nama`
--
ALTER TABLE `balik_nama`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_kpr`
--
ALTER TABLE `bank_kpr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang_keluar_detail`
--
ALTER TABLE `barang_keluar_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang_masuk_detail`
--
ALTER TABLE `barang_masuk_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bast`
--
ALTER TABLE `bast`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bphtb_ssp`
--
ALTER TABLE `bphtb_ssp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_tempo`
--
ALTER TABLE `customer_tempo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_akad`
--
ALTER TABLE `detail_akad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `file_aduan`
--
ALTER TABLE `file_aduan`
  ADD PRIMARY KEY (`id_file_aduan`);

--
-- Indexes for table `file_proses_aduan`
--
ALTER TABLE `file_proses_aduan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_aduan` (`id_aduan`);

--
-- Indexes for table `foto_progres`
--
ALTER TABLE `foto_progres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foto_proyek_bangunan`
--
ALTER TABLE `foto_proyek_bangunan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foto_proyek_jalan`
--
ALTER TABLE `foto_proyek_jalan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foto_proyek_saluran`
--
ALTER TABLE `foto_proyek_saluran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ganti_nama`
--
ALTER TABLE `ganti_nama`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ganti_namas`
--
ALTER TABLE `ganti_namas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hak_akses`
--
ALTER TABLE `hak_akses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hak_akses_panduan_apk`
--
ALTER TABLE `hak_akses_panduan_apk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hutang`
--
ALTER TABLE `hutang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `input_po`
--
ALTER TABLE `input_po`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `input_po_detail`
--
ALTER TABLE `input_po_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `input_po_pembayaran`
--
ALTER TABLE `input_po_pembayaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jalan`
--
ALTER TABLE `jalan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jenis_pekerjaan_bangunan`
--
ALTER TABLE `jenis_pekerjaan_bangunan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jenis_pekerjaan_jalan`
--
ALTER TABLE `jenis_pekerjaan_jalan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jenis_pekerjaan_saluran`
--
ALTER TABLE `jenis_pekerjaan_saluran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_transaksi`
--
ALTER TABLE `kategori_transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kavling_peta`
--
ALTER TABLE `kavling_peta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `konfigurasi`
--
ALTER TABLE `konfigurasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `konfigurasi_media`
--
ALTER TABLE `konfigurasi_media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `konfigurasi_wa`
--
ALTER TABLE `konfigurasi_wa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `legal`
--
ALTER TABLE `legal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listrik_air`
--
ALTER TABLE `listrik_air`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_aktivitas_pengguna`
--
ALTER TABLE `log_aktivitas_pengguna`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lokasi_kavling`
--
ALTER TABLE `lokasi_kavling`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lokasi_kavling_perusahaan`
--
ALTER TABLE `lokasi_kavling_perusahaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marketing_freelance`
--
ALTER TABLE `marketing_freelance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marketing_offline`
--
ALTER TABLE `marketing_offline`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_svg`
--
ALTER TABLE `master_svg`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_panduan_aplikasi`
--
ALTER TABLE `menu_panduan_aplikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metode_bayar`
--
ALTER TABLE `metode_bayar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mutasi_saldo`
--
ALTER TABLE `mutasi_saldo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notaris`
--
ALTER TABLE `notaris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemasukan_retensi`
--
ALTER TABLE `pemasukan_retensi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembelian_cancel`
--
ALTER TABLE `pembelian_cancel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengajuan_hold`
--
ALTER TABLE `pengajuan_hold`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengajuan_hold_tempo`
--
ALTER TABLE `pengajuan_hold_tempo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `persyaratan_legal`
--
ALTER TABLE `persyaratan_legal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `perusahaan`
--
ALTER TABLE `perusahaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pindah_unit`
--
ALTER TABLE `pindah_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piutang`
--
ALTER TABLE `piutang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ppjb`
--
ALTER TABLE `ppjb`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `progres_list_pembangunan`
--
ALTER TABLE `progres_list_pembangunan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `progres_list_penjualan`
--
ALTER TABLE `progres_list_penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `progres_unit_ready`
--
ALTER TABLE `progres_unit_ready`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prospek_customer`
--
ALTER TABLE `prospek_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_bangunan`
--
ALTER TABLE `proyek_bangunan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_bangunan_blok`
--
ALTER TABLE `proyek_bangunan_blok`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_bangunan_detail`
--
ALTER TABLE `proyek_bangunan_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_bangunan_detail_kerja`
--
ALTER TABLE `proyek_bangunan_detail_kerja`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_bangunan_unit`
--
ALTER TABLE `proyek_bangunan_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_jalan`
--
ALTER TABLE `proyek_jalan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_jalan_detail`
--
ALTER TABLE `proyek_jalan_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_jalan_detail_kerja`
--
ALTER TABLE `proyek_jalan_detail_kerja`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_saluran`
--
ALTER TABLE `proyek_saluran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_saluran_detail`
--
ALTER TABLE `proyek_saluran_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proyek_saluran_detail_kerja`
--
ALTER TABLE `proyek_saluran_detail_kerja`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rekap_akad`
--
ALTER TABLE `rekap_akad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retensi`
--
ALTER TABLE `retensi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `retensi_nama_retensi_unique` (`nama_retensi`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `saluran`
--
ALTER TABLE `saluran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `serah_terima_kunci`
--
ALTER TABLE `serah_terima_kunci`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sppr`
--
ALTER TABLE `sppr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spr`
--
ALTER TABLE `spr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `template_pesan`
--
ALTER TABLE `template_pesan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `throttle`
--
ALTER TABLE `throttle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `upload_file`
--
ALTER TABLE `upload_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variable_akad`
--
ALTER TABLE `variable_akad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wawancara`
--
ALTER TABLE `wawancara`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wawancara_sp3k`
--
ALTER TABLE `wawancara_sp3k`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aduan`
--
ALTER TABLE `aduan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aduan_proses`
--
ALTER TABLE `aduan_proses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `akad`
--
ALTER TABLE `akad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `balik_nama`
--
ALTER TABLE `balik_nama`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_kpr`
--
ALTER TABLE `bank_kpr`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barang_keluar_detail`
--
ALTER TABLE `barang_keluar_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barang_masuk_detail`
--
ALTER TABLE `barang_masuk_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bast`
--
ALTER TABLE `bast`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bphtb_ssp`
--
ALTER TABLE `bphtb_ssp`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_tempo`
--
ALTER TABLE `customer_tempo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_akad`
--
ALTER TABLE `detail_akad`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_aduan`
--
ALTER TABLE `file_aduan`
  MODIFY `id_file_aduan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_proses_aduan`
--
ALTER TABLE `file_proses_aduan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foto_progres`
--
ALTER TABLE `foto_progres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foto_proyek_bangunan`
--
ALTER TABLE `foto_proyek_bangunan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foto_proyek_jalan`
--
ALTER TABLE `foto_proyek_jalan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foto_proyek_saluran`
--
ALTER TABLE `foto_proyek_saluran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ganti_nama`
--
ALTER TABLE `ganti_nama`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ganti_namas`
--
ALTER TABLE `ganti_namas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hak_akses`
--
ALTER TABLE `hak_akses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2484;

--
-- AUTO_INCREMENT for table `hak_akses_panduan_apk`
--
ALTER TABLE `hak_akses_panduan_apk`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hutang`
--
ALTER TABLE `hutang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `input_po`
--
ALTER TABLE `input_po`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `input_po_detail`
--
ALTER TABLE `input_po_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `input_po_pembayaran`
--
ALTER TABLE `input_po_pembayaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jalan`
--
ALTER TABLE `jalan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_pekerjaan_bangunan`
--
ALTER TABLE `jenis_pekerjaan_bangunan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_pekerjaan_jalan`
--
ALTER TABLE `jenis_pekerjaan_jalan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_pekerjaan_saluran`
--
ALTER TABLE `jenis_pekerjaan_saluran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategori_transaksi`
--
ALTER TABLE `kategori_transaksi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kavling_peta`
--
ALTER TABLE `kavling_peta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=233;

--
-- AUTO_INCREMENT for table `konfigurasi`
--
ALTER TABLE `konfigurasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `konfigurasi_media`
--
ALTER TABLE `konfigurasi_media`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `konfigurasi_wa`
--
ALTER TABLE `konfigurasi_wa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legal`
--
ALTER TABLE `legal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listrik_air`
--
ALTER TABLE `listrik_air`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_aktivitas_pengguna`
--
ALTER TABLE `log_aktivitas_pengguna`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `lokasi_kavling`
--
ALTER TABLE `lokasi_kavling`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lokasi_kavling_perusahaan`
--
ALTER TABLE `lokasi_kavling_perusahaan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `marketing_freelance`
--
ALTER TABLE `marketing_freelance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketing_offline`
--
ALTER TABLE `marketing_offline`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_svg`
--
ALTER TABLE `master_svg`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `menu_panduan_aplikasi`
--
ALTER TABLE `menu_panduan_aplikasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metode_bayar`
--
ALTER TABLE `metode_bayar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mutasi_saldo`
--
ALTER TABLE `mutasi_saldo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notaris`
--
ALTER TABLE `notaris`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemasukan`
--
ALTER TABLE `pemasukan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pemasukan_retensi`
--
ALTER TABLE `pemasukan_retensi`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pembelian_cancel`
--
ALTER TABLE `pembelian_cancel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengajuan_hold`
--
ALTER TABLE `pengajuan_hold`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pengajuan_hold_tempo`
--
ALTER TABLE `pengajuan_hold_tempo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persyaratan_legal`
--
ALTER TABLE `persyaratan_legal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `perusahaan`
--
ALTER TABLE `perusahaan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pindah_unit`
--
ALTER TABLE `pindah_unit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `piutang`
--
ALTER TABLE `piutang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ppjb`
--
ALTER TABLE `ppjb`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `progres_list_pembangunan`
--
ALTER TABLE `progres_list_pembangunan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `progres_list_penjualan`
--
ALTER TABLE `progres_list_penjualan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `progres_unit_ready`
--
ALTER TABLE `progres_unit_ready`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prospek_customer`
--
ALTER TABLE `prospek_customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_bangunan`
--
ALTER TABLE `proyek_bangunan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_bangunan_blok`
--
ALTER TABLE `proyek_bangunan_blok`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_bangunan_detail`
--
ALTER TABLE `proyek_bangunan_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_bangunan_detail_kerja`
--
ALTER TABLE `proyek_bangunan_detail_kerja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_bangunan_unit`
--
ALTER TABLE `proyek_bangunan_unit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_jalan`
--
ALTER TABLE `proyek_jalan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_jalan_detail`
--
ALTER TABLE `proyek_jalan_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_jalan_detail_kerja`
--
ALTER TABLE `proyek_jalan_detail_kerja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_saluran`
--
ALTER TABLE `proyek_saluran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_saluran_detail`
--
ALTER TABLE `proyek_saluran_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proyek_saluran_detail_kerja`
--
ALTER TABLE `proyek_saluran_detail_kerja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rekap_akad`
--
ALTER TABLE `rekap_akad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `retensi`
--
ALTER TABLE `retensi`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=596;

--
-- AUTO_INCREMENT for table `saluran`
--
ALTER TABLE `saluran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `satuan`
--
ALTER TABLE `satuan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `serah_terima_kunci`
--
ALTER TABLE `serah_terima_kunci`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sppr`
--
ALTER TABLE `sppr`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spr`
--
ALTER TABLE `spr`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `template_pesan`
--
ALTER TABLE `template_pesan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `upload_file`
--
ALTER TABLE `upload_file`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `variable_akad`
--
ALTER TABLE `variable_akad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wawancara`
--
ALTER TABLE `wawancara`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wawancara_sp3k`
--
ALTER TABLE `wawancara_sp3k`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
