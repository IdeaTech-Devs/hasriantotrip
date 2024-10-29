-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20230513.2d5cb03077
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2024 at 05:53 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perjalanankeseharian_212002`
--

-- --------------------------------------------------------

--
-- Table structure for table `category_212002`
--

CREATE TABLE `category_212002` (
  `id_kategori` int NOT NULL,
  `nama_kategori` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `waktu_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_212002`
--

CREATE TABLE `detail_212002` (
  `id_detail` int NOT NULL,
  `deskripsi` varchar(200) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lokasi_212002`
--

CREATE TABLE `lokasi_212002` (
  `id_lokasi` int NOT NULL,
  `nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `perjalanan_21002`
--

CREATE TABLE `perjalanan_21002` (
  `id_catatan` int NOT NULL,
  `waktu_keberangkatan` datetime NOT NULL,
  `waktu_sampai` datetime NOT NULL,
  `id_lokasi` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `catatan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_212002`
--

CREATE TABLE `users_212002` (
  `id` int NOT NULL,
  `nik` varchar(16) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `kata_sandi` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `gambar` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `peran` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'USER',
  `status` varchar(10) COLLATE utf8mb4_general_ci DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_212002`
--

INSERT INTO `users_212002` (`id`, `nik`, `nama`, `email`, `kata_sandi`, `gambar`, `peran`, `status`, `created_at`, `updated_at`) VALUES
(95, '6789012345678901', 'Aqib', 'aqib@example.com', '12345', 'aqib.jpg', 'USER', 'ACTIVE', '2024-10-21 17:15:56', '2024-10-21 17:15:56'),
(96, '7890123456789012', 'Hasrianto', 'hasrianto@example.com', '12345', 'hasrianto.jpg', 'USER', 'ACTIVE', '2024-10-21 17:15:56', '2024-10-21 17:15:56'),
(98, '12345', 'ahmadaqib', 'aqib@gmail.com', '12345', 'default.png', 'USER', 'ACTIVE', '2024-10-29 12:49:30', '2024-10-29 12:49:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category_212002`
--
ALTER TABLE `category_212002`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `detail_212002`
--
ALTER TABLE `detail_212002`
  ADD PRIMARY KEY (`id_detail`);

--
-- Indexes for table `lokasi_212002`
--
ALTER TABLE `lokasi_212002`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indexes for table `perjalanan_21002`
--
ALTER TABLE `perjalanan_21002`
  ADD PRIMARY KEY (`id_catatan`),
  ADD KEY `id_lokasi` (`id_lokasi`),
  ADD KEY `id_pengguna` (`id_pengguna`);

--
-- Indexes for table `users_212002`
--
ALTER TABLE `users_212002`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category_212002`
--
ALTER TABLE `category_212002`
  MODIFY `id_kategori` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `detail_212002`
--
ALTER TABLE `detail_212002`
  MODIFY `id_detail` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lokasi_212002`
--
ALTER TABLE `lokasi_212002`
  MODIFY `id_lokasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `perjalanan_21002`
--
ALTER TABLE `perjalanan_21002`
  MODIFY `id_catatan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_212002`
--
ALTER TABLE `users_212002`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `perjalanan_21002`
--
ALTER TABLE `perjalanan_21002`
  ADD CONSTRAINT `perjalanan_21002_ibfk_1` FOREIGN KEY (`id_lokasi`) REFERENCES `lokasi_212002` (`id_lokasi`) ON DELETE CASCADE,
  ADD CONSTRAINT `perjalanan_21002_ibfk_2` FOREIGN KEY (`id_pengguna`) REFERENCES `users_212002` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
