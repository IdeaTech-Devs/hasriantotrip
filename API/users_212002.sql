-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20230513.2d5cb03077
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2024 at 01:16 PM
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
(95, '6789012345678901', 'Aqib', 'aqib@gmail.com', '12345', 'aqib.jpg', 'USER', 'ACTIVE', '2024-10-21 17:15:56', '2024-10-21 17:15:56'),
(96, '7890123456789012', 'Hasrianto', 'hasrianto@gmail.com', '12345', 'hasrianto.jpg', 'USER', 'ACTIVE', '2024-10-21 17:15:56', '2024-10-21 17:15:56');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `users_212002`
--
ALTER TABLE `users_212002`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
