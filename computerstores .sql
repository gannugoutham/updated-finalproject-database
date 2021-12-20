-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2021 at 05:35 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `computerstores`
--

-- --------------------------------------------------------

--
-- Table structure for table `cust`
--

DROP TABLE IF EXISTS `cust`;
CREATE TABLE `cust` (
  `id` int(4) NOT NULL,
  `name` varchar(128) NOT NULL,
  `mobile` varchar(56) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cust`
--

INSERT INTO `cust` (`id`, `name`, `mobile`, `addr`, `status`) VALUES
(1, 'John', '9874563210', 'klsdjkvljzxcvkzxmc,.vz', '1'),
(2, 'Dunk', '4569871230', 'dsmfvz,.mcxv,.zmnv,.zxcn', '1'),
(3, 'Doe', '7894561230', 'xyz place', '1'),
(4, 'Kane', '4569871230', 'BEKKSIJKKKS789966', '1');

-- --------------------------------------------------------

--
-- Stand-in structure for view `list`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `list`;
CREATE TABLE `list` (
`org` varchar(128)
,`id` int(11)
,`orgid` int(11)
,`custid` int(11)
,`delievery_status` int(4)
,`total` int(11)
,`name` varchar(128)
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `orgid` int(11) NOT NULL,
  `custid` int(11) NOT NULL,
  `delievery_status` int(4) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `orgid`, `custid`, `delievery_status`, `total`) VALUES
(1, 3, 2, 2, 15000),
(2, 3, 2, 2, 15200);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `ordid` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `quantity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `ordid`, `product`, `quantity`) VALUES
(1, 1, 5, 1),
(2, 2, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `org`
--

DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `location` int(4) NOT NULL,
  `addr` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `org`
--

INSERT INTO `org` (`id`, `name`, `location`, `addr`) VALUES
(3, 'GOorg', 1, 'DFSDFMDF,.SMD.,FSF');

-- --------------------------------------------------------

--
-- Stand-in structure for view `orgdata`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `orgdata`;
CREATE TABLE `orgdata` (
`org` varchar(126)
,`id` int(11)
,`name` varchar(128)
,`location` int(4)
,`addr` text
);

-- --------------------------------------------------------

--
-- Table structure for table `org_emp`
--

DROP TABLE IF EXISTS `org_emp`;
CREATE TABLE `org_emp` (
  `id` int(11) NOT NULL,
  `name` varchar(126) NOT NULL,
  `orgid` int(11) NOT NULL,
  `contactnum` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `org_emp`
--

INSERT INTO `org_emp` (`id`, `name`, `orgid`, `contactnum`) VALUES
(3, 'FGDM,G,.FSDFG', 3, 788877);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `price` int(11) NOT NULL,
  `specifications` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `specifications`) VALUES
(5, 'JKLKLJGKLJDFG', 1000, 'RNDFND,SFMFSDF'),
(6, 'SDFGDFGDF', 7880, 'SDFSSDFGCGDFGDFGDFG');

--
-- Triggers `products`
--
DROP TRIGGER IF EXISTS `price_sum`;
DELIMITER $$
CREATE TRIGGER `price_sum` BEFORE INSERT ON `products` FOR EACH ROW SET @sum = @sum + NEW.price
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `list`
--
DROP TABLE IF EXISTS `list`;

DROP VIEW IF EXISTS `list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `list`  AS SELECT `og`.`name` AS `org`, `od`.`id` AS `id`, `od`.`orgid` AS `orgid`, `od`.`custid` AS `custid`, `od`.`delievery_status` AS `delievery_status`, `od`.`total` AS `total`, `c`.`name` AS `name` FROM ((`org` `og` join `orders` `od` on(`od`.`orgid` = `og`.`id`)) join `cust` `c` on(`c`.`id` = `od`.`custid`)) ;

-- --------------------------------------------------------

--
-- Structure for view `orgdata`
--
DROP TABLE IF EXISTS `orgdata`;

DROP VIEW IF EXISTS `orgdata`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orgdata`  AS SELECT `oge`.`name` AS `org`, `og`.`id` AS `id`, `og`.`name` AS `name`, `og`.`location` AS `location`, `og`.`addr` AS `addr` FROM (`org` `og` join `org_emp` `oge` on(`oge`.`orgid` = `og`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cust`
--
ALTER TABLE `cust`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orgid` (`orgid`),
  ADD KEY `custid` (`custid`),
  ADD KEY `delievery_status` (`delievery_status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ordid` (`ordid`),
  ADD KEY `product` (`product`);

--
-- Indexes for table `org`
--
ALTER TABLE `org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `org_emp`
--
ALTER TABLE `org_emp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orgid` (`orgid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cust`
--
ALTER TABLE `cust`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `org`
--
ALTER TABLE `org`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `org_emp`
--
ALTER TABLE `org_emp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`orgid`) REFERENCES `org` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`custid`) REFERENCES `cust` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`delievery_status`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`ordid`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `org_emp`
--
ALTER TABLE `org_emp`
  ADD CONSTRAINT `org_emp_ibfk_1` FOREIGN KEY (`orgid`) REFERENCES `org` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
