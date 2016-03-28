-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 22, 2015 at 03:17 PM
-- Server version: 5.5.46-0ubuntu0.14.04.2
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Payroll`
--

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE IF NOT EXISTS `Account` (
  `acct_id` varchar(8) NOT NULL,
  `acct_pw` varchar(32) NOT NULL,
  `acct_plain_pw` varchar(32) DEFAULT NULL,
  `acct_status` varchar(1) DEFAULT NULL,
  `acct_eff_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Activities`
--

CREATE TABLE IF NOT EXISTS `Activities` (
  `act_code` varchar(3) NOT NULL,
  `act_descr` varchar(64) NOT NULL,
  `act_effective_date` date DEFAULT NULL,
  PRIMARY KEY (`act_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Departments`
--

CREATE TABLE IF NOT EXISTS `Departments` (
  `dept_no` varchar(6) NOT NULL,
  `dept_bp_no` varchar(12) DEFAULT NULL,
  `dept_short_name` varchar(16) NOT NULL,
  `dept_long_name` varchar(64) DEFAULT NULL,
  `dept_eff_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE IF NOT EXISTS `Employees` (
  `emp_pidn` varchar(7) NOT NULL COMMENT 'system employee number',
  `emp_id` varchar(8) NOT NULL COMMENT 'net login',
  `emp_fname` varchar(32) NOT NULL COMMENT 'first name',
  `emp_lname` int(32) NOT NULL COMMENT 'last name',
  `emp_type` varchar(1) NOT NULL,
  `emp_status` varchar(1) NOT NULL,
  `emp_activity_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_pidn`),
  UNIQUE KEY `emp_id` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reference employee detail table for more info';

-- --------------------------------------------------------

--
-- Table structure for table `Entries`
--

CREATE TABLE IF NOT EXISTS `Entries` (
  `ent_emp_pidn` varchar(7) NOT NULL,
  `ent_posn_no` varchar(5) NOT NULL,
  `ent_dept_no` varchar(6) NOT NULL,
  `ent_act_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ent_act_date` date NOT NULL,
  `ent_act_code` tinyint(4) NOT NULL,
  `ent_source` varchar(32) NOT NULL,
  `ent_mod_id` varchar(7) DEFAULT NULL,
  `ent_mod_no` tinyint(4) DEFAULT NULL,
  `ent_mod_date` date DEFAULT NULL,
  `ent_mod_reason` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Positions`
--

CREATE TABLE IF NOT EXISTS `Positions` (
  `posn_no` varchar(6) NOT NULL COMMENT 'position number',
  `posn_pidn` varchar(7) NOT NULL COMMENT 'employee primary number',
  `posn_descr` varchar(64) NOT NULL COMMENT 'description',
  `posn_sal_type` varchar(2) DEFAULT NULL COMMENT 'salary type',
  `posn_status` varchar(1) NOT NULL COMMENT 'status of position',
  `posn_emp_pct` tinyint(4) DEFAULT NULL COMMENT 'numeral percentage max 100',
  `posn_base_hrs` int(11) DEFAULT NULL COMMENT 'number of payroll hrs',
  `posn_base_rate` decimal(10,0) DEFAULT NULL COMMENT 'pay per hour',
  `posn_pay_id` varchar(2) DEFAULT NULL COMMENT 'identifies the pay group',
  `posn_start_date` date DEFAULT NULL COMMENT 'date posn started',
  `posn_eff_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date posn was entered into system',
  `posn_end_date` date DEFAULT NULL COMMENT 'last day position was available for use in system'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Payroll Position Info';


CREATE TABLE IF NOT EXISTS `Earnings` (
  `earn_period` VARCHAR(2) NOT NULL COMMENT 'In order 01, 02, 03 ... 26',
  `earn_year` VARCHAR(4) NOT NULL,
  `earn_pidn` VARCHAR(7) NOT NULL COMMENT 'Employee system id from the Employees table',
  `earn_posn` VARCHAR(6) NOT NULL COMMENT 'From Positions table the id ex: CN3410',
  `earn_hrs` FLOAT(6,2) NOT NULL COMMENT 'Hours employee worked for this entry',
  `earn_amount` FLOAT(8,2) NOT NULL COMMENT 'Disbursed amount',
  `earn_entry_date` date DEFAULT NULL COMMENT 'date of insertion in this table',
  `earn_disposition` VARCHAR(2) NOT NULL COMMENT 'Based on dispositions table sequence',
  `earn_agent` VARCHAR(8) NOT NULL COMMENT 'Employee plain id that made the insertion from the Employees table'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Payroll Enployee Payroll info';

CREATE TABLE IF NOT EXISTS `Paycal` (
  `pcal_period` VARCHAR(2) NOT NULL COMMENT 'In order 01, 02, 03 ... 26',
  `pcal_year` VARCHAR(4) NOT NULL,
  `pcal_start_date` date NOT NULL COMMENT 'First date of the pay period',
  `pcal_end_date` date NOT NULL COMMENT 'Last date of the pay period',
  `pcal_pay_date` date NOT NULL COMMENT 'Date of disbursment'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Payroll Enployee Payroll Calendar info';




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
