-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2024 at 10:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: `perjalanankeseharian_212002`

-- --------------------------------------------------------
-- Tabel untuk menyimpan data pengguna
-- --------------------------------------------------------

CREATE TABLE `users_212002` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(16) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `kata_sandi` varchar(255) NOT NULL,
  `gambar` varchar(50) NOT NULL,
  `peran` varchar(20) DEFAULT 'USER',
  `status` varchar(10) DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel untuk menyimpan lokasi
-- --------------------------------------------------------

CREATE TABLE `lokasi_212002` (
  `id_lokasi` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel untuk menyimpan kategori
-- --------------------------------------------------------

CREATE TABLE `category_212002` (
  `id_kategori` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(50) NOT NULL,
  `waktu_dibuat` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel untuk menyimpan catatan perjalanan
-- --------------------------------------------------------

CREATE TABLE `perjalanan_21002` (
  `id_catatan` int(11) NOT NULL AUTO_INCREMENT,
  `waktu_keberangkatan` datetime NOT NULL,
  `waktu_sampai` datetime NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_pengguna` int(11) NOT NULL,
  PRIMARY KEY (`id_catatan`),
  FOREIGN KEY (`id_lokasi`) REFERENCES `lokasi_212002` (`id_lokasi`) ON DELETE CASCADE,
  FOREIGN KEY (`id_pengguna`) REFERENCES `users_212002` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Indexes for dumped tables
-- --------------------------------------------------------

-- No need for additional `ALTER TABLE` statements to add primary keys, as they are defined in the `CREATE TABLE` statements.

-- Indexes for table `perjalanan_21002`
ALTER TABLE `perjalanan_21002`
  ADD KEY `id_lokasi` (`id_lokasi`),
  ADD KEY `id_pengguna` (`id_pengguna`);

-- --------------------------------------------------------
-- AUTO_INCREMENT for dumped tables
-- --------------------------------------------------------

-- AUTO_INCREMENT for table `category_212002`
ALTER TABLE `category_212002`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

-- AUTO_INCREMENT for table `lokasi_212002`
ALTER TABLE `lokasi_212002`
  MODIFY `id_lokasi` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT for table `perjalanan_21002`
ALTER TABLE `perjalanan_21002`
  MODIFY `id_catatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

-- AUTO_INCREMENT for table `users_212002`
ALTER TABLE `users_212002`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
