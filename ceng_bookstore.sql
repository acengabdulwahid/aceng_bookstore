-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 07 Jun 2019 pada 09.44
-- Versi Server: 10.1.30-MariaDB
-- PHP Version: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ceng_bookstore`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` varchar(15) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `jenis` varchar(20) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `penulis` varchar(50) NOT NULL,
  `penerbit` varchar(50) NOT NULL,
  `tahun` varchar(4) DEFAULT NULL,
  `stok` int(3) NOT NULL,
  `harga_pokok` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `jenis`, `isbn`, `penulis`, `penerbit`, `tahun`, `stok`, `harga_pokok`, `harga_jual`) VALUES
('A0001', 'Pemrograman Berorientasi Objek', 'Komputer', '98972868368648', 'Beben Sutara S.Kom., M.T.', 'STMIK Sumedang', '2019', 19, 55000, 65000),
('A0002', 'Kemerdekaan Indonesia', 'Sejarah', '79386864186886', 'Soekarno', 'Gramedia', '2006', 18, 45000, 60000),
('A0003', 'Pemrograman Web', 'Teknologi', '83868361868686', 'Aceng', 'Informatika Bandung', '2019', 24, 50000, 58000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `distributor`
--

CREATE TABLE `distributor` (
  `id_distributor` varchar(15) NOT NULL,
  `nama_distributor` varchar(50) NOT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `distributor`
--

INSERT INTO `distributor` (`id_distributor`, `nama_distributor`, `alamat`, `telepon`) VALUES
('D0001', 'PT. Gramedia', 'Jakarta Pusat', '0211112233'),
('D0002', 'PT. Salemba', 'Cikarang Bekasi', '0222333444');

-- --------------------------------------------------------

--
-- Stand-in structure for view `laporan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `laporan` (
`id_buku` varchar(15)
,`judul` varchar(50)
,`jenis` varchar(20)
,`jumlah` int(11)
,`tanggal_beli` timestamp
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` varchar(15) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `jenis_kelamin` varchar(1) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `jenis_kelamin`, `alamat`) VALUES
('PL0000', '-', '-', '-'),
('PL0001', '-', '-', '-'),
('PL0002', 'Adah Rosyadah', 'P', 'Sumedang'),
('PL0003', 'Akbar Nur Syahrudin', 'L', 'Indramayu'),
('PL0004', 'Alip Lasmana', 'L', 'Sumedang'),
('PL0005', 'Asep Budiman', 'L', 'Sumedang'),
('PL0006', 'Chaerul Fikri', 'L', 'Sumedang'),
('PL0008', 'Farid Adhitya', 'L', 'Sumedang'),
('PL0009', 'Hafidh Fauzan', 'L', 'Sumedang');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `id_pretransaksi` varchar(15) NOT NULL,
  `id_transaksi` varchar(15) NOT NULL,
  `id_pelanggan` varchar(15) NOT NULL,
  `id_buku` varchar(15) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`id_pretransaksi`, `id_transaksi`, `id_pelanggan`, `id_buku`, `jumlah`, `sub_total`) VALUES
('PS0001', 'TR0001', 'PL0001', 'A0001', 1, 65000),
('PS0002', 'TR0002', 'PL0002', 'A0003', 1, 58000);

--
-- Trigger `penjualan`
--
DELIMITER $$
CREATE TRIGGER `Batal` AFTER DELETE ON `penjualan` FOR EACH ROW UPDATE buku SET stok = stok + OLD.jumlah WHERE id_buku = OLD.id_buku
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Beli` AFTER INSERT ON `penjualan` FOR EACH ROW UPDATE buku SET buku.stok = buku.stok - NEW.jumlah WHERE buku.id_buku = NEW.id_buku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan2`
--

CREATE TABLE `penjualan2` (
  `id_transaksi` varchar(15) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `total` int(50) NOT NULL,
  `tanggal_beli` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `penjualan2`
--

INSERT INTO `penjualan2` (`id_transaksi`, `nama_pelanggan`, `total`, `tanggal_beli`) VALUES
('TR0001', '-', 65000, '2019-06-07 04:04:23'),
('TR0002', 'Adah Rosyadah', 58000, '2019-06-07 04:07:26');

-- --------------------------------------------------------

--
-- Stand-in structure for view `struk_bayar`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `struk_bayar` (
`nama_pelanggan` varchar(50)
,`total` int(50)
,`tanggal_beli` timestamp
,`id_transaksi` varchar(15)
,`jumlah` int(11)
,`sub_total` int(11)
,`judul` varchar(50)
,`harga_jual` int(11)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(3) NOT NULL,
  `nama_user` varchar(50) NOT NULL,
  `alamat_user` varchar(255) DEFAULT NULL,
  `telepon_user` varchar(15) DEFAULT NULL,
  `status` enum('0','1') NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `akses` enum('kasir','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `alamat_user`, `telepon_user`, `status`, `username`, `password`, `akses`) VALUES
(1, 'Administrator', 'Ceng Book Store Majalengka', '082118771688', '1', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin'),
(2, 'Kasir', 'Ceng Book Store Majalengka', '082118771689', '1', 'kasir', 'c7911af3adbd12a035b289556d96470a', 'kasir'),
(3, 'Aceng Abdul Wahid', 'Majalengka', '0895357303458', '1', 'aceng', '149eecba3ed9350e988206828080553d', 'kasir');

-- --------------------------------------------------------

--
-- Struktur untuk view `laporan`
--
DROP TABLE IF EXISTS `laporan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan`  AS  select `buku`.`id_buku` AS `id_buku`,`buku`.`judul` AS `judul`,`buku`.`jenis` AS `jenis`,`penjualan`.`jumlah` AS `jumlah`,`penjualan2`.`tanggal_beli` AS `tanggal_beli` from ((`buku` join `penjualan` on((`buku`.`id_buku` = `penjualan`.`id_buku`))) join `penjualan2` on((`buku`.`id_buku` = `penjualan`.`id_buku`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `struk_bayar`
--
DROP TABLE IF EXISTS `struk_bayar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `struk_bayar`  AS  select `penjualan2`.`nama_pelanggan` AS `nama_pelanggan`,`penjualan2`.`total` AS `total`,`penjualan2`.`tanggal_beli` AS `tanggal_beli`,`penjualan`.`id_transaksi` AS `id_transaksi`,`penjualan`.`jumlah` AS `jumlah`,`penjualan`.`sub_total` AS `sub_total`,`buku`.`judul` AS `judul`,`buku`.`harga_jual` AS `harga_jual` from ((`penjualan2` join `penjualan` on((`penjualan2`.`id_transaksi` = `penjualan`.`id_transaksi`))) join `buku` on((`penjualan`.`id_buku` = `buku`.`id_buku`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`id_distributor`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id_pretransaksi`);

--
-- Indexes for table `penjualan2`
--
ALTER TABLE `penjualan2`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
