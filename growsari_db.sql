-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 26, 2026 at 10:30 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `growsari_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `barangays`
--

CREATE TABLE `barangays` (
  `barangay_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `barangay_name` varchar(100) NOT NULL,
  `population` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barangays`
--

INSERT INTO `barangays` (`barangay_id`, `city_id`, `barangay_name`, `population`, `created_at`) VALUES
(1, 1, 'Tondo', 628106, '2026-01-26 09:21:14'),
(2, 1, 'Ermita', 8506, '2026-01-26 09:21:14'),
(3, 2, 'Commonwealth', 198285, '2026-01-26 09:21:14'),
(4, 2, 'Batasan Hills', 161409, '2026-01-26 09:21:14'),
(5, 3, 'Poblacion', 71041, '2026-01-26 09:21:14'),
(6, 4, 'Poblacion 1', 3245, '2026-01-26 09:21:14'),
(7, 4, 'Bantayan', 7832, '2026-01-26 09:21:14'),
(8, 4, 'Candau-ay', 5621, '2026-01-26 09:21:14'),
(9, 6, 'Mandalagan', 82341, '2026-01-26 09:21:14'),
(10, 7, 'Lahug', 19469, '2026-01-26 09:21:14'),
(11, 9, 'Poblacion', 38545, '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `city_id` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `city_type` enum('City','Municipality') NOT NULL,
  `population` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`city_id`, `province_id`, `city_name`, `city_type`, `population`, `created_at`) VALUES
(1, 1, 'Manila', 'City', 1780148, '2026-01-26 09:21:14'),
(2, 1, 'Quezon City', 'City', 2960048, '2026-01-26 09:21:14'),
(3, 1, 'Makati', 'City', 629616, '2026-01-26 09:21:14'),
(4, 2, 'Dumaguete', 'City', 134103, '2026-01-26 09:21:14'),
(5, 2, 'Bais', 'City', 84317, '2026-01-26 09:21:14'),
(6, 3, 'Bacolod', 'City', 600783, '2026-01-26 09:21:14'),
(7, 4, 'Cebu City', 'City', 964169, '2026-01-26 09:21:14'),
(8, 4, 'Mandaue', 'City', 364116, '2026-01-26 09:21:14'),
(9, 6, 'Davao City', 'City', 1776949, '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `credit_transactions`
--

CREATE TABLE `credit_transactions` (
  `credit_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `transaction_type` enum('Credit Given','Payment Received','Credit Adjustment') NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `balance_before` decimal(12,2) NOT NULL,
  `balance_after` decimal(12,2) NOT NULL,
  `due_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `plate_number` varchar(20) DEFAULT NULL,
  `dispatch_time` datetime DEFAULT NULL,
  `estimated_arrival` datetime DEFAULT NULL,
  `actual_arrival` datetime DEFAULT NULL,
  `status` enum('Pending','In Transit','Delivered','Failed','Returned') DEFAULT 'Pending',
  `delivery_notes` text DEFAULT NULL,
  `received_by` varchar(100) DEFAULT NULL,
  `signature_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`delivery_id`, `order_id`, `driver_name`, `vehicle_type`, `plate_number`, `dispatch_time`, `estimated_arrival`, `actual_arrival`, `status`, `delivery_notes`, `received_by`, `signature_image`, `created_at`) VALUES
(1, 1, 'Ramil Cruz', 'Motorcycle', 'ABC-1234', '2026-01-21 07:00:00', NULL, '2026-01-21 09:30:00', 'Delivered', NULL, 'Maria Santos', NULL, '2026-01-26 09:24:24'),
(2, 2, 'Danny Lopez', 'Van', 'XYZ-5678', '2026-01-21 07:30:00', NULL, '2026-01-21 10:15:00', 'Delivered', NULL, 'Juan Dela Cruz', NULL, '2026-01-26 09:24:24'),
(3, 3, 'Rico Martinez', 'Motorcycle', 'DEF-9012', '2026-01-22 08:00:00', NULL, NULL, 'In Transit', NULL, NULL, NULL, '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_ratings`
--

CREATE TABLE `delivery_ratings` (
  `rating_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_ratings`
--

INSERT INTO `delivery_ratings` (`rating_id`, `delivery_id`, `rating`, `feedback`, `created_at`) VALUES
(1, 1, 5, 'On time delivery. Rider was polite.', '2026-01-26 09:24:24'),
(2, 2, 5, 'Complete order. No damage. Excellent!', '2026-01-26 09:24:24'),
(3, 3, 4, 'Still waiting but tracking is good.', '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity_in_stock` int(11) DEFAULT 0,
  `reorder_level` int(11) DEFAULT 50,
  `reorder_quantity` int(11) DEFAULT 100,
  `last_restock_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `warehouse_id`, `product_id`, `quantity_in_stock`, `reorder_level`, `reorder_quantity`, `last_restock_date`, `expiry_date`, `batch_number`, `updated_at`) VALUES
(1, 1, 1, 500, 100, 500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(2, 1, 2, 480, 100, 500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(3, 1, 3, 450, 100, 500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(4, 1, 6, 800, 200, 1000, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(5, 1, 7, 1500, 300, 2000, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(6, 1, 13, 300, 50, 300, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(7, 1, 14, 280, 50, 300, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(8, 1, 20, 450, 100, 500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(9, 1, 25, 600, 150, 800, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(10, 1, 30, 1200, 200, 1500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(11, 2, 1, 350, 80, 400, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(12, 2, 6, 600, 150, 800, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(13, 2, 13, 200, 40, 250, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(14, 2, 20, 300, 80, 400, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(15, 2, 25, 400, 100, 500, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(16, 3, 1, 250, 60, 300, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(17, 3, 6, 450, 120, 600, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(18, 3, 13, 150, 30, 200, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(19, 3, 20, 220, 60, 300, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(20, 4, 1, 400, 90, 450, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(21, 4, 6, 550, 140, 700, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(22, 4, 13, 180, 35, 220, NULL, NULL, NULL, '2026-01-26 09:24:24'),
(23, 4, 20, 280, 70, 350, NULL, NULL, NULL, '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `manufacturer_id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `company_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'Philippines',
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`manufacturer_id`, `company_name`, `company_code`, `country`, `contact_person`, `email`, `phone`, `is_active`, `created_at`) VALUES
(1, 'Unilever Philippines', 'UNILEVER', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(2, 'Nestle Philippines', 'NESTLE', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(3, 'Universal Robina Corporation', 'URC', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(4, 'San Miguel Corporation', 'SMC', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(5, 'Procter & Gamble Philippines', 'P&G', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(6, 'Alaska Milk Corporation', 'ALASKA', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(7, 'Century Pacific Food Inc.', 'CENTURY', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(8, 'Monde Nissin Corporation', 'MONDE', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(9, 'Jack n Jill', 'JNJ', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14'),
(10, 'Oishi', 'OISHI', 'Philippines', NULL, NULL, NULL, 1, '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `store_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `status` enum('Pending','Confirmed','Processing','Packed','Out for Delivery','Delivered','Cancelled') DEFAULT 'Pending',
  `payment_method` enum('Cash','Credit','GCash','Bank Transfer','COD') DEFAULT 'COD',
  `payment_status` enum('Unpaid','Partially Paid','Paid') DEFAULT 'Unpaid',
  `subtotal` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) DEFAULT 0.00,
  `delivery_fee` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `order_number`, `store_id`, `warehouse_id`, `order_date`, `delivery_date`, `status`, `payment_method`, `payment_status`, `subtotal`, `discount_amount`, `delivery_fee`, `total_amount`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'ORD-2026-00001', 1, 1, '2026-01-20 09:30:00', '2026-01-21', 'Delivered', 'COD', 'Paid', 1250.00, 50.00, 50.00, 1250.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(2, 'ORD-2026-00002', 2, 1, '2026-01-20 10:15:00', '2026-01-21', 'Delivered', 'Credit', 'Paid', 3500.00, 150.00, 100.00, 3450.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(3, 'ORD-2026-00003', 3, 4, '2026-01-21 08:45:00', '2026-01-22', 'Out for Delivery', 'GCash', 'Paid', 950.00, 0.00, 50.00, 1000.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(4, 'ORD-2026-00004', 4, 2, '2026-01-21 11:20:00', '2026-01-23', 'Processing', 'Credit', 'Unpaid', 5200.00, 200.00, 150.00, 5150.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(5, 'ORD-2026-00005', 5, 1, '2026-01-22 09:00:00', '2026-01-23', 'Confirmed', 'COD', 'Unpaid', 800.00, 0.00, 50.00, 850.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(6, 'ORD-2026-00006', 6, 2, '2026-01-22 14:30:00', '2026-01-24', 'Pending', 'Credit', 'Unpaid', 8500.00, 500.00, 200.00, 8200.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(7, 'ORD-2026-00007', 1, 1, '2026-01-23 10:00:00', '2026-01-24', 'Confirmed', 'Cash', 'Paid', 1100.00, 0.00, 50.00, 1150.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(8, 'ORD-2026-00008', 7, 4, '2026-01-23 15:45:00', '2026-01-25', 'Pending', 'COD', 'Unpaid', 650.00, 0.00, 50.00, 700.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(9, 'ORD-2026-00009', 8, 2, '2026-01-24 08:20:00', '2026-01-26', 'Confirmed', 'GCash', 'Paid', 4200.00, 200.00, 150.00, 4150.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(10, 'ORD-2026-00010', 9, 1, '2026-01-24 11:30:00', '2026-01-25', 'Processing', 'Credit', 'Partially Paid', 720.00, 0.00, 50.00, 770.00, NULL, '2026-01-26 09:24:24', '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `total_price` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`, `discount_percent`, `discount_amount`, `total_price`) VALUES
(1, 1, 1, 20, 12.50, 250.00, 0.00, 0.00, 250.00),
(2, 1, 6, 10, 45.00, 450.00, 0.00, 25.00, 425.00),
(3, 1, 13, 15, 28.00, 420.00, 0.00, 20.00, 400.00),
(4, 1, 25, 5, 38.00, 190.00, 0.00, 5.00, 185.00),
(5, 2, 1, 50, 12.50, 625.00, 0.00, 50.00, 575.00),
(6, 2, 6, 30, 45.00, 1350.00, 0.00, 50.00, 1300.00),
(7, 2, 13, 20, 28.00, 560.00, 0.00, 20.00, 540.00),
(8, 2, 20, 25, 32.00, 800.00, 0.00, 30.00, 770.00),
(9, 2, 30, 20, 5.00, 100.00, 0.00, 0.00, 100.00),
(10, 3, 2, 15, 12.50, 187.50, 0.00, 0.00, 187.50),
(11, 3, 7, 20, 15.00, 300.00, 0.00, 0.00, 300.00),
(12, 3, 14, 10, 22.00, 220.00, 0.00, 0.00, 220.00),
(13, 3, 26, 8, 38.00, 304.00, 0.00, 0.00, 304.00),
(14, 4, 1, 80, 12.50, 1000.00, 0.00, 80.00, 920.00),
(15, 4, 6, 50, 45.00, 2250.00, 0.00, 100.00, 2150.00),
(16, 4, 13, 30, 28.00, 840.00, 0.00, 20.00, 820.00),
(17, 4, 25, 35, 38.00, 1330.00, 0.00, 0.00, 1330.00),
(18, 5, 3, 12, 12.50, 150.00, 0.00, 0.00, 150.00),
(19, 5, 8, 8, 45.00, 360.00, 0.00, 0.00, 360.00),
(20, 5, 15, 10, 22.00, 220.00, 0.00, 0.00, 220.00),
(21, 6, 1, 100, 12.50, 1250.00, 0.00, 0.00, 1250.00),
(22, 6, 6, 80, 45.00, 3600.00, 0.00, 0.00, 3600.00),
(23, 6, 13, 50, 28.00, 1400.00, 0.00, 0.00, 1400.00),
(24, 7, 1, 25, 12.50, 312.50, 0.00, 0.00, 312.50),
(25, 7, 10, 15, 18.00, 270.00, 0.00, 0.00, 270.00),
(26, 7, 20, 12, 32.00, 384.00, 0.00, 0.00, 384.00),
(27, 8, 2, 18, 12.50, 225.00, 0.00, 0.00, 225.00),
(28, 8, 7, 12, 15.00, 180.00, 0.00, 0.00, 180.00),
(29, 8, 14, 8, 22.00, 176.00, 0.00, 0.00, 176.00);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` enum('Cash','GCash','Bank Transfer','PayMaya','Credit Card') NOT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `payment_status` enum('Pending','Completed','Failed','Refunded') DEFAULT 'Completed',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_date`, `payment_method`, `reference_number`, `amount_paid`, `payment_status`, `notes`, `created_at`) VALUES
(1, 1, '2026-01-21 09:30:00', 'Cash', 'CASH-001', 1250.00, 'Completed', NULL, '2026-01-26 09:24:24'),
(2, 2, '2026-01-21 10:15:00', 'GCash', 'GCASH-20260121-001', 3450.00, 'Completed', NULL, '2026-01-26 09:24:24'),
(3, 3, '2026-01-21 11:00:00', 'GCash', 'GCASH-20260121-002', 1000.00, 'Completed', NULL, '2026-01-26 09:24:24'),
(4, 7, '2026-01-23 10:00:00', 'Cash', 'CASH-002', 1150.00, 'Completed', NULL, '2026-01-26 09:24:24'),
(5, 9, '2026-01-24 08:30:00', 'GCash', 'GCASH-20260124-001', 4150.00, 'Completed', NULL, '2026-01-26 09:24:24'),
(6, 10, '2026-01-24 12:00:00', 'GCash', 'GCASH-20260124-002', 400.00, 'Completed', NULL, '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `product_name` varchar(200) NOT NULL,
  `category_id` int(11) NOT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `unit_of_measure` enum('piece','pack','sachet','bottle','can','box','kg','gram','liter','ml') DEFAULT 'piece',
  `base_price` decimal(10,2) NOT NULL,
  `suggested_retail_price` decimal(10,2) NOT NULL,
  `weight_grams` int(11) DEFAULT NULL,
  `is_perishable` tinyint(1) DEFAULT 0,
  `requires_refrigeration` tinyint(1) DEFAULT 0,
  `shelf_life_days` int(11) DEFAULT NULL,
  `min_order_quantity` int(11) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_code`, `barcode`, `product_name`, `category_id`, `manufacturer_id`, `description`, `unit_of_measure`, `base_price`, `suggested_retail_price`, `weight_grams`, `is_perishable`, `requires_refrigeration`, `shelf_life_days`, `min_order_quantity`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'LUCKY-ME-001', '4800016644801', 'Lucky Me Pancit Canton Original', 6, 8, NULL, 'pack', 12.50, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(2, 'LUCKY-ME-002', '4800016644818', 'Lucky Me Pancit Canton Chilimansi', 6, 8, NULL, 'pack', 12.50, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(3, 'LUCKY-ME-003', '4800016644825', 'Lucky Me Pancit Canton Sweet & Spicy', 6, 8, NULL, 'pack', 12.50, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(4, 'NISSIN-001', '4807770270109', 'Nissin Cup Noodles Seafood', 6, 8, NULL, 'piece', 25.00, 30.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(5, 'PAYLESS-001', '4800024644235', 'Payless Pancit Canton', 6, 8, NULL, 'pack', 10.00, 12.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(6, 'COKE-001', '4800888100014', 'Coca-Cola 1.5L', 5, 4, NULL, 'bottle', 45.00, 55.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(7, 'COKE-002', '4800888100021', 'Coca-Cola 8oz', 5, 4, NULL, 'bottle', 15.00, 18.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(8, 'SPRITE-001', '4800888100038', 'Sprite 1.5L', 5, 4, NULL, 'bottle', 45.00, 55.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(9, 'RC-001', '4800024155014', 'RC Cola 1.5L', 5, 4, NULL, 'bottle', 38.00, 45.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(10, 'C2-001', '4800092191018', 'C2 Green Tea Apple', 5, 3, NULL, 'bottle', 18.00, 22.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(11, 'ZEST-O-001', '4800092140010', 'Zest-O Orange', 5, 3, NULL, 'pack', 10.00, 12.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(12, 'TANG-001', '4800024654321', 'Tang Orange 25g', 5, 1, NULL, 'sachet', 8.00, 10.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(13, '555-TUNA-001', '4800024789012', '555 Tuna Flakes in Oil', 7, 7, NULL, 'can', 28.00, 35.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(14, 'LIGO-001', '4800024123456', 'Ligo Sardines Red', 7, 7, NULL, 'can', 22.00, 28.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(15, 'CENTURY-001', '4800092345678', 'Century Tuna Flakes', 7, 7, NULL, 'can', 28.00, 35.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(16, 'SPAM-001', '4800000123456', 'Spam Classic', 7, 7, NULL, 'can', 180.00, 220.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(17, 'PUREFOODS-001', '4800092456789', 'Purefoods Corned Beef', 7, 4, NULL, 'can', 65.00, 80.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(18, 'UFC-001', '4800092234567', 'UFC Banana Catsup 320g', 8, 1, NULL, 'bottle', 32.00, 40.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(19, 'PAPA-001', '4800092345612', 'Papa Banana Catsup', 8, 1, NULL, 'bottle', 28.00, 35.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(20, 'DATU-PUTI-001', '4800092111111', 'Datu Puti Soy Sauce 385ml', 8, 1, NULL, 'bottle', 18.00, 22.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(21, 'DATU-PUTI-002', '4800092111112', 'Datu Puti Vinegar 385ml', 8, 1, NULL, 'bottle', 15.00, 18.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(22, 'SILVER-SWAN-001', '4800092222222', 'Silver Swan Soy Sauce', 8, 1, NULL, 'bottle', 18.00, 22.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(23, 'MAGGI-001', '4800092333333', 'Maggi Magic Sarap 8g', 8, 2, NULL, 'sachet', 3.00, 4.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(24, 'KNORR-001', '4800092444444', 'Knorr Cubes Pork', 8, 1, NULL, 'piece', 5.00, 6.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(25, 'ALASKA-001', '4800092555555', 'Alaska Evaporated Milk 370ml', 9, 6, NULL, 'can', 38.00, 45.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(26, 'BEAR-BRAND-001', '4800092666666', 'Bear Brand Powdered Milk 33g', 9, 2, NULL, 'sachet', 12.00, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(27, 'BIRCH-TREE-001', '4800092777777', 'Birch Tree Fortified 33g', 9, 2, NULL, 'sachet', 12.00, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(28, 'PALMOLIVE-001', '4800092888888', 'Palmolive Shampoo Naturals 12ml', 10, 5, NULL, 'sachet', 5.00, 6.50, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(29, 'SUNSILK-001', '4800092999999', 'Sunsilk Shampoo Black Shine 12ml', 10, 1, NULL, 'sachet', 5.00, 6.50, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(30, 'SAFEGUARD-001', '4800093111111', 'Safeguard Bar Soap White', 10, 5, NULL, 'piece', 28.00, 35.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(31, 'DOVE-001', '4800093222222', 'Dove Beauty Bar', 10, 1, NULL, 'piece', 38.00, 45.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(32, 'COLGATE-001', '4800093333333', 'Colgate Total 12 25ml', 11, 5, NULL, 'piece', 18.00, 22.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(33, 'CLOSEUP-001', '4800093444444', 'Close Up Red Hot 25ml', 11, 1, NULL, 'piece', 15.00, 18.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(34, 'TIDE-001', '4800093555555', 'Tide Powder 25g', 12, 5, NULL, 'sachet', 5.00, 6.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(35, 'ARIEL-001', '4800093666666', 'Ariel Powder 25g', 12, 5, NULL, 'sachet', 5.00, 6.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(36, 'SURF-001', '4800093777777', 'Surf Powder 25g', 12, 1, NULL, 'sachet', 4.50, 5.50, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(37, 'CHAMPION-001', '4800093888888', 'Champion Liquid Detergent 25ml', 12, 1, NULL, 'sachet', 4.00, 5.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(38, 'ZONROX-001', '4800093999999', 'Zonrox Bleach 1L', 13, 5, NULL, 'bottle', 35.00, 42.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(39, 'DOMEX-001', '4800094111111', 'Domex Toilet Bowl Cleaner', 13, 1, NULL, 'bottle', 45.00, 55.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(40, 'CHIPPY-001', '4800094222222', 'Chippy BBQ', 14, 9, NULL, 'pack', 8.00, 10.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(41, 'PIATTOS-001', '4800094333333', 'Piattos Cheese', 14, 9, NULL, 'pack', 8.00, 10.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(42, 'NOVA-001', '4800094444444', 'Nova Multigrain BBQ', 14, 9, NULL, 'pack', 8.00, 10.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(43, 'OISHI-PRAWN-001', '4800094555555', 'Oishi Prawn Crackers Spicy', 14, 10, NULL, 'pack', 8.00, 10.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(44, 'STORCK-001', '4800094666666', 'Storck Knoppers', 15, 1, NULL, 'piece', 15.00, 18.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(45, 'MENTOS-001', '4800094777777', 'Mentos Mint', 15, 1, NULL, '', 12.00, 15.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15'),
(46, 'HALLS-001', '4800094888888', 'Halls Extra Strong', 15, 1, NULL, 'piece', 3.00, 4.00, NULL, 0, 0, NULL, 1, 1, '2026-01-26 09:21:15', '2026-01-26 09:21:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`category_id`, `category_name`, `parent_category_id`, `description`, `display_order`, `is_active`) VALUES
(1, 'Food & Beverages', NULL, NULL, 1, 1),
(2, 'Personal Care', NULL, NULL, 2, 1),
(3, 'Household', NULL, NULL, 3, 1),
(4, 'Snacks & Sweets', NULL, NULL, 4, 1),
(5, 'Beverages', 1, NULL, 1, 1),
(6, 'Instant Noodles', 1, NULL, 2, 1),
(7, 'Canned Goods', 1, NULL, 3, 1),
(8, 'Condiments', 1, NULL, 4, 1),
(9, 'Dairy Products', 1, NULL, 5, 1),
(10, 'Shampoo & Soap', 2, NULL, 1, 1),
(11, 'Toothpaste', 2, NULL, 2, 1),
(12, 'Laundry', 3, NULL, 1, 1),
(13, 'Cleaning Supplies', 3, NULL, 2, 1),
(14, 'Chips', 4, NULL, 1, 1),
(15, 'Candy', 4, NULL, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `is_verified_purchase` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`review_id`, `product_id`, `store_id`, `rating`, `review_text`, `is_verified_purchase`, `created_at`) VALUES
(1, 1, 1, 5, 'Masarap! Bestseller sa store ko.', 1, '2026-01-26 09:24:24'),
(2, 6, 2, 4, 'Mabilis maubos. Customers love it.', 1, '2026-01-26 09:24:24'),
(3, 13, 3, 5, 'Good quality canned goods.', 1, '2026-01-26 09:24:24'),
(4, 20, 4, 4, 'Ok naman, pero minsan nagkakaroon ng shortage.', 1, '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `product_suppliers`
--

CREATE TABLE `product_suppliers` (
  `ps_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `supplier_price` decimal(10,2) NOT NULL,
  `is_preferred` tinyint(1) DEFAULT 0,
  `last_supply_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `promotion_id` int(11) NOT NULL,
  `promotion_name` varchar(150) NOT NULL,
  `promotion_code` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('Percentage','Fixed Amount','Buy X Get Y') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_purchase_amount` decimal(12,2) DEFAULT 0.00,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `max_uses` int(11) DEFAULT NULL,
  `current_uses` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`promotion_id`, `promotion_name`, `promotion_code`, `description`, `discount_type`, `discount_value`, `min_purchase_amount`, `start_date`, `end_date`, `max_uses`, `current_uses`, `is_active`, `created_at`) VALUES
(1, 'New Year Flash Sale', 'NEWYEAR2026', NULL, 'Percentage', 10.00, 0.00, '2026-01-01', '2026-01-31', NULL, 0, 1, '2026-01-26 09:24:24'),
(2, 'Buy 10 Get 5% Off', 'BUY10', NULL, 'Percentage', 5.00, 0.00, '2026-01-15', '2026-02-28', NULL, 0, 1, '2026-01-26 09:24:24'),
(3, 'Valentine Promo', 'VDAY2026', NULL, 'Fixed Amount', 50.00, 0.00, '2026-02-01', '2026-02-14', NULL, 0, 1, '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `promotion_products`
--

CREATE TABLE `promotion_products` (
  `pp_id` int(11) NOT NULL,
  `promotion_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `province_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `province_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`province_id`, `region_id`, `province_name`, `created_at`) VALUES
(1, 1, 'Metro Manila', '2026-01-26 09:21:14'),
(2, 7, 'Negros Oriental', '2026-01-26 09:21:14'),
(3, 7, 'Negros Occidental', '2026-01-26 09:21:14'),
(4, 10, 'Cebu', '2026-01-26 09:21:14'),
(5, 10, 'Bohol', '2026-01-26 09:21:14'),
(6, 14, 'Davao del Sur', '2026-01-26 09:21:14'),
(7, 14, 'Davao del Norte', '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `region_id` int(11) NOT NULL,
  `region_code` varchar(10) NOT NULL,
  `region_name` varchar(100) NOT NULL,
  `island_group` enum('Luzon','Visayas','Mindanao') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`region_id`, `region_code`, `region_name`, `island_group`, `created_at`) VALUES
(1, 'NCR', 'National Capital Region', 'Luzon', '2026-01-26 09:21:14'),
(2, 'CAR', 'Cordillera Administrative Region', 'Luzon', '2026-01-26 09:21:14'),
(3, 'I', 'Ilocos Region', 'Luzon', '2026-01-26 09:21:14'),
(4, 'II', 'Cagayan Valley', 'Luzon', '2026-01-26 09:21:14'),
(5, 'III', 'Central Luzon', 'Luzon', '2026-01-26 09:21:14'),
(6, 'IV-A', 'CALABARZON', 'Luzon', '2026-01-26 09:21:14'),
(7, 'IV-B', 'MIMAROPA', 'Luzon', '2026-01-26 09:21:14'),
(8, 'V', 'Bicol Region', 'Luzon', '2026-01-26 09:21:14'),
(9, 'VI', 'Western Visayas', 'Visayas', '2026-01-26 09:21:14'),
(10, 'VII', 'Central Visayas', 'Visayas', '2026-01-26 09:21:14'),
(11, 'VIII', 'Eastern Visayas', 'Visayas', '2026-01-26 09:21:14'),
(12, 'IX', 'Zamboanga Peninsula', 'Mindanao', '2026-01-26 09:21:14'),
(13, 'X', 'Northern Mindanao', 'Mindanao', '2026-01-26 09:21:14'),
(14, 'XI', 'Davao Region', 'Mindanao', '2026-01-26 09:21:14'),
(15, 'XII', 'SOCCSKSARGEN', 'Mindanao', '2026-01-26 09:21:14'),
(16, 'XIII', 'Caraga', 'Mindanao', '2026-01-26 09:21:14'),
(17, 'BARMM', 'Bangsamoro Autonomous Region', 'Mindanao', '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `store_name` varchar(150) NOT NULL,
  `barangay_id` int(11) NOT NULL,
  `street_address` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `store_type` enum('Sari-Sari Store','Mini Grocery','Convenience Store') DEFAULT 'Sari-Sari Store',
  `store_size` enum('Small','Medium','Large') DEFAULT 'Small',
  `has_refrigerator` tinyint(1) DEFAULT 0,
  `has_wifi` tinyint(1) DEFAULT 0,
  `monthly_revenue` decimal(12,2) DEFAULT NULL,
  `credit_limit` decimal(12,2) DEFAULT 5000.00,
  `current_debt` decimal(12,2) DEFAULT 0.00,
  `credit_score` int(11) DEFAULT 50,
  `registration_date` date NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`store_id`, `owner_id`, `store_name`, `barangay_id`, `street_address`, `latitude`, `longitude`, `store_type`, `store_size`, `has_refrigerator`, `has_wifi`, `monthly_revenue`, `credit_limit`, `current_debt`, `credit_score`, `registration_date`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Aling Mariyas Sari-Sari Store', 6, NULL, NULL, NULL, 'Sari-Sari Store', 'Small', 0, 0, NULL, 10000.00, 0.00, 50, '2023-01-15', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(2, 2, 'Tiong Juan Store', 4, NULL, NULL, NULL, 'Mini Grocery', 'Small', 0, 0, NULL, 25000.00, 0.00, 50, '2023-02-20', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(3, 3, 'Anas Variety Store', 8, NULL, NULL, NULL, 'Sari-Sari Store', 'Small', 0, 0, NULL, 8000.00, 0.00, 50, '2023-03-10', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(4, 4, 'Pedros Grocery', 9, NULL, NULL, NULL, 'Mini Grocery', 'Small', 0, 0, NULL, 30000.00, 0.00, 50, '2023-04-05', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(5, 5, 'Rosa Store', 6, NULL, NULL, NULL, 'Sari-Sari Store', 'Small', 0, 0, NULL, 5000.00, 0.00, 50, '2023-05-12', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(6, 6, 'Joses Mini Mart', 7, NULL, NULL, NULL, 'Convenience Store', 'Small', 0, 0, NULL, 50000.00, 0.00, 50, '2023-06-18', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(7, 7, 'Lindas Tindahan', 8, NULL, NULL, NULL, 'Sari-Sari Store', 'Small', 0, 0, NULL, 7000.00, 0.00, 50, '2023-07-22', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(8, 8, 'Carlos Convenience Store', 10, NULL, NULL, NULL, 'Convenience Store', 'Small', 0, 0, NULL, 40000.00, 0.00, 50, '2023-08-30', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(9, 9, 'Elenas Store', 6, NULL, NULL, NULL, 'Sari-Sari Store', 'Small', 0, 0, NULL, 6000.00, 0.00, 50, '2023-09-14', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24'),
(10, 10, 'Miguels Grocery', 11, NULL, NULL, NULL, 'Mini Grocery', 'Small', 0, 0, NULL, 35000.00, 0.00, 50, '2023-10-25', 0, 1, '2026-01-26 09:24:24', '2026-01-26 09:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `store_owners`
--

CREATE TABLE `store_owners` (
  `owner_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `id_type` enum('National ID','Drivers License','Passport','Voters ID') DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `registered_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `store_owners`
--

INSERT INTO `store_owners` (`owner_id`, `first_name`, `last_name`, `middle_name`, `mobile_number`, `email`, `birthdate`, `gender`, `id_type`, `id_number`, `registered_at`, `last_login`, `is_active`) VALUES
(1, 'Maria', 'Santos', NULL, '09171234501', 'maria.santos@gmail.com', NULL, 'Female', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(2, 'Juan', 'Dela Cruz', NULL, '09181234502', 'juan.delacruz@gmail.com', NULL, 'Male', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(3, 'Ana', 'Reyes', NULL, '09191234503', 'ana.reyes@yahoo.com', NULL, 'Female', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(4, 'Pedro', 'Garcia', NULL, '09201234504', 'pedro.garcia@gmail.com', NULL, 'Male', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(5, 'Rosa', 'Mendoza', NULL, '09211234505', 'rosa.mendoza@gmail.com', NULL, 'Female', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(6, 'Jose', 'Ramos', NULL, '09221234506', 'jose.ramos@yahoo.com', NULL, 'Male', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(7, 'Linda', 'Fernandez', NULL, '09231234507', 'linda.f@gmail.com', NULL, 'Female', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(8, 'Carlos', 'Torres', NULL, '09241234508', 'carlos.torres@gmail.com', NULL, 'Male', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(9, 'Elena', 'Cruz', NULL, '09251234509', 'elena.cruz@yahoo.com', NULL, 'Female', NULL, NULL, '2026-01-26 09:24:24', NULL, 1),
(10, 'Miguel', 'Villanueva', NULL, '09261234510', 'miguel.v@gmail.com', NULL, 'Male', NULL, NULL, '2026-01-26 09:24:24', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(150) NOT NULL,
  `supplier_code` varchar(20) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `payment_terms` enum('Cash','COD','7 days','15 days','30 days') DEFAULT 'COD',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `supplier_code`, `contact_person`, `mobile_number`, `email`, `city_id`, `address`, `payment_terms`, `is_active`, `created_at`) VALUES
(1, 'Metro Wholesale', 'MW001', 'Juan dela Cruz', '09171234567', NULL, 1, NULL, '7 days', 1, '2026-01-26 09:21:14'),
(2, 'Puregold Price Club', 'PG001', 'Maria Santos', '09181234567', NULL, 2, NULL, 'COD', 1, '2026-01-26 09:21:14'),
(3, 'S&R Membership Shopping', 'SR001', 'Pedro Reyes', '09191234567', NULL, 3, NULL, '15 days', 1, '2026-01-26 09:21:14'),
(4, 'Landers Superstore', 'LS001', 'Ana Garcia', '09201234567', NULL, 3, NULL, '30 days', 1, '2026-01-26 09:21:14'),
(5, 'All Day Supermarket', 'ADS001', 'Jose Mercado', '09211234567', NULL, 2, NULL, '7 days', 1, '2026-01-26 09:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `warehouse_id` int(11) NOT NULL,
  `warehouse_name` varchar(100) NOT NULL,
  `warehouse_code` varchar(20) DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `address` text DEFAULT NULL,
  `capacity_cubic_meters` decimal(10,2) DEFAULT NULL,
  `manager_name` varchar(100) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`warehouse_id`, `warehouse_name`, `warehouse_code`, `city_id`, `address`, `capacity_cubic_meters`, `manager_name`, `contact_number`, `is_active`, `created_at`) VALUES
(1, 'Growsari Metro Manila Hub', 'WH-NCR-001', 2, NULL, NULL, 'Roberto Santos', '09171111111', 1, '2026-01-26 09:24:24'),
(2, 'Growsari Cebu Distribution Center', 'WH-CEB-001', 7, NULL, NULL, 'Carmen Lopez', '09182222222', 1, '2026-01-26 09:24:24'),
(3, 'Growsari Davao Warehouse', 'WH-DAV-001', 9, NULL, NULL, 'Fernando Reyes', '09193333333', 1, '2026-01-26 09:24:24'),
(4, 'Growsari Bacolod Hub', 'WH-BAC-001', 6, NULL, NULL, 'Gloria Martinez', '09204444444', 1, '2026-01-26 09:24:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barangays`
--
ALTER TABLE `barangays`
  ADD PRIMARY KEY (`barangay_id`),
  ADD KEY `idx_city` (`city_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `idx_province` (`province_id`);

--
-- Indexes for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  ADD PRIMARY KEY (`credit_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_date` (`created_at`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `delivery_ratings`
--
ALTER TABLE `delivery_ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `idx_delivery` (`delivery_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD UNIQUE KEY `unique_warehouse_product_batch` (`warehouse_id`,`product_id`,`batch_number`),
  ADD KEY `idx_warehouse` (`warehouse_id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`manufacturer_id`),
  ADD UNIQUE KEY `company_code` (`company_code`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `warehouse_id` (`warehouse_id`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_date` (`order_date`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_date` (`payment_date`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_code` (`product_code`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `manufacturer_id` (`manufacturer_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_barcode` (`barcode`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `idx_parent` (`parent_category_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `idx_product` (`product_id`),
  ADD KEY `idx_rating` (`rating`);

--
-- Indexes for table `product_suppliers`
--
ALTER TABLE `product_suppliers`
  ADD PRIMARY KEY (`ps_id`),
  ADD UNIQUE KEY `unique_product_supplier` (`product_id`,`supplier_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promotion_id`),
  ADD UNIQUE KEY `promotion_code` (`promotion_code`),
  ADD KEY `idx_code` (`promotion_code`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

--
-- Indexes for table `promotion_products`
--
ALTER TABLE `promotion_products`
  ADD PRIMARY KEY (`pp_id`),
  ADD UNIQUE KEY `unique_promo_product` (`promotion_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`province_id`),
  ADD KEY `idx_region` (`region_id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`region_id`),
  ADD UNIQUE KEY `region_code` (`region_code`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`),
  ADD KEY `idx_owner` (`owner_id`),
  ADD KEY `idx_location` (`barangay_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `store_owners`
--
ALTER TABLE `store_owners`
  ADD PRIMARY KEY (`owner_id`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`),
  ADD KEY `idx_mobile` (`mobile_number`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `supplier_code` (`supplier_code`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`warehouse_id`),
  ADD UNIQUE KEY `warehouse_code` (`warehouse_code`),
  ADD KEY `city_id` (`city_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barangays`
--
ALTER TABLE `barangays`
  MODIFY `barangay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  MODIFY `credit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delivery_ratings`
--
ALTER TABLE `delivery_ratings`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_suppliers`
--
ALTER TABLE `product_suppliers`
  MODIFY `ps_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `promotion_products`
--
ALTER TABLE `promotion_products`
  MODIFY `pp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `province_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `store_owners`
--
ALTER TABLE `store_owners`
  MODIFY `owner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `warehouse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barangays`
--
ALTER TABLE `barangays`
  ADD CONSTRAINT `barangays_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`);

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`province_id`);

--
-- Constraints for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  ADD CONSTRAINT `credit_transactions_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `credit_transactions_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `delivery_ratings`
--
ALTER TABLE `delivery_ratings`
  ADD CONSTRAINT `delivery_ratings_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`delivery_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`category_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`manufacturer_id`);

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `product_categories` (`category_id`);

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Constraints for table `product_suppliers`
--
ALTER TABLE `product_suppliers`
  ADD CONSTRAINT `product_suppliers_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_suppliers_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `promotion_products`
--
ALTER TABLE `promotion_products`
  ADD CONSTRAINT `promotion_products_ibfk_1` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `promotion_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `provinces`
--
ALTER TABLE `provinces`
  ADD CONSTRAINT `provinces_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`region_id`);

--
-- Constraints for table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `store_owners` (`owner_id`),
  ADD CONSTRAINT `stores_ibfk_2` FOREIGN KEY (`barangay_id`) REFERENCES `barangays` (`barangay_id`);

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`);

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
