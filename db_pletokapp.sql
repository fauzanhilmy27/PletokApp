-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2021 at 09:59 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pletokapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_meja`
--

CREATE TABLE `tb_meja` (
  `nomor_meja` varchar(2) NOT NULL,
  `status` enum('tersedia','tidak tersedia') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_meja`
--

INSERT INTO `tb_meja` (`nomor_meja`, `status`) VALUES
('01', 'tersedia'),
('02', 'tidak tersedia'),
('03', 'tersedia'),
('04', 'tersedia'),
('05', 'tidak tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `tb_menu`
--

CREATE TABLE `tb_menu` (
  `id_menu` varchar(10) NOT NULL,
  `nama_menu` varchar(40) NOT NULL,
  `harga` int(12) NOT NULL,
  `stok` enum('tersedia','tidak tersedia') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_menu`
--

INSERT INTO `tb_menu` (`id_menu`, `nama_menu`, `harga`, `stok`) VALUES
('01-PLORG', 'Pletok Original', 19000, 'tersedia'),
('02-PLSTR', 'Pletok Stoberi', 22000, 'tersedia'),
('03-PLAGR', 'Pletok Anggur', 20000, 'tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pegawai`
--

CREATE TABLE `tb_pegawai` (
  `id_pegawai` varchar(10) NOT NULL,
  `nama_pegawai` varchar(40) NOT NULL,
  `notelp_pegawai` varchar(14) NOT NULL,
  `alamat` text NOT NULL,
  `password` varchar(100) NOT NULL,
  `jabatan` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_pegawai`
--

INSERT INTO `tb_pegawai` (`id_pegawai`, `nama_pegawai`, `notelp_pegawai`, `alamat`, `password`, `jabatan`) VALUES
('P01', 'Ujang', '089562316237', 'Jl.sukrawetan kec.sukra kab.indramayu Bo.29', '1234', 'Pelayan'),
('P02', 'Larasati', '089726636162', 'Jl.Sekeawi kec.sukamenak kab.bandung no.31', '5678', 'Kasir');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pelanggan`
--

CREATE TABLE `tb_pelanggan` (
  `nomor_pelanggan` varchar(10) NOT NULL,
  `nomor_meja` varchar(2) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `tgl_pemesanan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_pelanggan`
--

INSERT INTO `tb_pelanggan` (`nomor_pelanggan`, `nomor_meja`, `nama_pelanggan`, `tgl_pemesanan`) VALUES
('050721001', '01', 'Asep Balon', '2021-07-05'),
('050721002', '03', 'Suptianto', '2021-07-05'),
('050721003', '04', 'Sukuna', '2021-07-05');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pembayaran`
--

CREATE TABLE `tb_pembayaran` (
  `id_pembayaran` varchar(10) NOT NULL,
  `id_pegawai` varchar(10) NOT NULL,
  `id_pesanan` varchar(15) NOT NULL,
  `metode_bayar` enum('cash','debit') NOT NULL,
  `total_bayar` int(12) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_pembayaran`
--

INSERT INTO `tb_pembayaran` (`id_pembayaran`, `id_pegawai`, `id_pesanan`, `metode_bayar`, `total_bayar`) VALUES
('050721-001', 'P02', '050721-001-001', 'cash', 267000);

-- --------------------------------------------------------

--
-- Table structure for table `tb_pesanan`
--

CREATE TABLE `tb_pesanan` (
  `id_pesanan` varchar(15) NOT NULL,
  `nomor_pelanggan` varchar(10) NOT NULL,
  `tgl_pemesanan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_pesanan`
--

INSERT INTO `tb_pesanan` (`id_pesanan`, `nomor_pelanggan`, `tgl_pemesanan`) VALUES
('050721-001-001', '050721001', '2021-07-05'),
('050721-002-002', '050721002', '2021-07-05'),
('050721-003-003', '050721003', '2021-07-05');

-- --------------------------------------------------------

--
-- Table structure for table `tb_rincian_pesanan`
--

CREATE TABLE `tb_rincian_pesanan` (
  `id_pesanan` varchar(15) NOT NULL,
  `id_menu` varchar(10) NOT NULL,
  `jumlah_pesanan` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_rincian_pesanan`
--

INSERT INTO `tb_rincian_pesanan` (`id_pesanan`, `id_menu`, `jumlah_pesanan`) VALUES
('050721-001-001', '01-PLORG', 3),
('050721-001-001', '02-PLSTR', 5),
('050721-001-001', '03-PLAGR', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_meja`
--
ALTER TABLE `tb_meja`
  ADD PRIMARY KEY (`nomor_meja`);

--
-- Indexes for table `tb_menu`
--
ALTER TABLE `tb_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indexes for table `tb_pegawai`
--
ALTER TABLE `tb_pegawai`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indexes for table `tb_pelanggan`
--
ALTER TABLE `tb_pelanggan`
  ADD PRIMARY KEY (`nomor_pelanggan`),
  ADD KEY `nomor_meja` (`nomor_meja`);

--
-- Indexes for table `tb_pembayaran`
--
ALTER TABLE `tb_pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_pegawai` (`id_pegawai`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `tb_pesanan`
--
ALTER TABLE `tb_pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `nomor_pelanggan` (`nomor_pelanggan`);

--
-- Indexes for table `tb_rincian_pesanan`
--
ALTER TABLE `tb_rincian_pesanan`
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_pelanggan`
--
ALTER TABLE `tb_pelanggan`
  ADD CONSTRAINT `tb_pelanggan_ibfk_1` FOREIGN KEY (`nomor_meja`) REFERENCES `tb_meja` (`nomor_meja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_pembayaran`
--
ALTER TABLE `tb_pembayaran`
  ADD CONSTRAINT `tb_pembayaran_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `tb_pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_pembayaran_ibfk_2` FOREIGN KEY (`id_pesanan`) REFERENCES `tb_pesanan` (`id_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_pesanan`
--
ALTER TABLE `tb_pesanan`
  ADD CONSTRAINT `tb_pesanan_ibfk_1` FOREIGN KEY (`nomor_pelanggan`) REFERENCES `tb_pelanggan` (`nomor_pelanggan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_rincian_pesanan`
--
ALTER TABLE `tb_rincian_pesanan`
  ADD CONSTRAINT `tb_rincian_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `tb_pesanan` (`id_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_rincian_pesanan_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `tb_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
