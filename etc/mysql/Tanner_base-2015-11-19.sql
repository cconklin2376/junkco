-- phpMyAdmin SQL Dump
-- version 4.4.15.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 19, 2015 at 08:13 PM
-- Server version: 5.5.44-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Tanner`
--

-- --------------------------------------------------------

--
-- Table structure for table `SPBPERS`
--

CREATE TABLE IF NOT EXISTS `SPBPERS` (
  `spbpers_pidm` varchar(6) NOT NULL,
  `spbpers_gender` varchar(1) DEFAULT NULL,
  `spbpers_ssn` varchar(11) NOT NULL,
  `spbpers_dob` date NOT NULL,
  `spbpers_marital_status` varchar(1) NOT NULL,
  `spbpers_race` varchar(1) DEFAULT NULL,
  `spbpers_entry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SPRADDR`
--

CREATE TABLE IF NOT EXISTS `SPRADDR` (
  `spraddr_pidm` varchar(6) NOT NULL,
  `spraddr_type` varchar(12) NOT NULL,
  `spraddr_status` varchar(1) NOT NULL,
  `spraddr_street1` varchar(32) DEFAULT NULL,
  `spraddr_street2` varchar(32) DEFAULT NULL,
  `spraddr_apt` varchar(12) DEFAULT NULL,
  `spraddr_box` varchar(12) DEFAULT NULL,
  `spraddr_city` varchar(32) DEFAULT NULL,
  `spraddr_state` varchar(2) DEFAULT NULL,
  `spraddr_zip` varchar(12) DEFAULT NULL,
  `spraddr_county` varchar(12) DEFAULT NULL,
  `spraddr_activity_date` date NOT NULL,
  `spraddr_effective_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SPRIDEN`
--

CREATE TABLE IF NOT EXISTS `SPRIDEN` (
  `spriden_pidm` varchar(6) NOT NULL,
  `spriden_id` varchar(9) NOT NULL,
  `spriden_eid` varchar(7) NOT NULL,
  `spriden_status` int(11) DEFAULT NULL,
  `spriden_first_name` varchar(32) NOT NULL,
  `spriden_last_name` varchar(32) NOT NULL,
  `spriden_mi` varchar(32) DEFAULT NULL,
  `spriden_suffix` varchar(12) NOT NULL,
  `spriden_pref_name` varchar(32) DEFAULT NULL,
  `spriden_change_ind` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `SPRIDEN`
--
ALTER TABLE `SPRIDEN`
  ADD PRIMARY KEY (`spriden_pidm`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
