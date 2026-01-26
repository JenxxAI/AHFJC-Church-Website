-- AHFJCPI Database Schema
-- Run this SQL in phpMyAdmin or MySQL console

CREATE DATABASE IF NOT EXISTS ahfjcpi_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ahfjcpi_db;

-- Admin Users Table
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('super_admin', 'admin', 'editor') DEFAULT 'editor',
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_username (username)
) ENGINE=InnoDB;

-- Leadership Table
CREATE TABLE IF NOT EXISTS leadership (
    id INT AUTO_INCREMENT PRIMARY KEY,
    position VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Churches Table
CREATE TABLE IF NOT EXISTS churches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    church_name VARCHAR(100) NOT NULL,
    pastor_name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_active (is_active)
) ENGINE=InnoDB;

-- Events Table
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_title VARCHAR(200) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME,
    location VARCHAR(255),
    church_id INT,
    description TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (church_id) REFERENCES churches(id) ON DELETE SET NULL,
    INDEX idx_date (event_date),
    INDEX idx_active (is_active)
) ENGINE=InnoDB;

-- Ministry Posts Table
CREATE TABLE IF NOT EXISTS ministry_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category ENUM('outreach', 'fellowship', 'mission', 'baptism') NOT NULL,
    title VARCHAR(200) NOT NULL,
    post_date DATE NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    church_id INT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (church_id) REFERENCES churches(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_date (post_date)
) ENGINE=InnoDB;

-- Testimonies Table
CREATE TABLE IF NOT EXISTS testimonies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    church_id INT,
    testimony TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (church_id) REFERENCES churches(id) ON DELETE SET NULL,
    INDEX idx_approved (is_approved)
) ENGINE=InnoDB;

-- Resources Table
CREATE TABLE IF NOT EXISTS resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resource_type VARCHAR(50) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    file_url VARCHAR(255),
    download_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_type (resource_type)
) ENGINE=InnoDB;

-- Prayer Requests Table
CREATE TABLE IF NOT EXISTS prayer_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    request TEXT NOT NULL,
    is_answered BOOLEAN DEFAULT FALSE,
    is_public BOOLEAN DEFAULT FALSE,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_date (submitted_at)
) ENGINE=InnoDB;

-- Gallery Images Table
CREATE TABLE IF NOT EXISTS gallery_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    description TEXT,
    image_url VARCHAR(255) NOT NULL,
    category VARCHAR(50),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category)
) ENGINE=InnoDB;

-- Settings Table
CREATE TABLE IF NOT EXISTS settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Insert Default Admin (Password: admin123 - CHANGE THIS!)
INSERT INTO admins (username, password, email, full_name, role) 
VALUES ('admin', '$2y$10$xxNVn09Mzk.h.W8Zh5RPROrEKqs0ZR5xT7lo1hsTSNYmeIPPhB8ea', 'admin@ahfjcpi.org', 'System Administrator', 'super_admin');

-- Insert Leadership
INSERT INTO leadership (position, full_name, description, display_order) VALUES
('Bishop', 'Ricardo S. Concepcion', 'Spiritual Overseer', 1),
('Chairman', 'Jonadick Maxilom', 'Organizational Leader', 2),
('Vice Chairman', 'Joemar Aligato', 'Assistant Leader', 3);

-- Insert Churches
INSERT INTO churches (church_name, pastor_name, location, display_order) VALUES
('Sagay Church', 'Pastor Ricardo S. Concepcion', 'Sagay, Negros Oriental', 1),
('Tamlang Church', 'Pastor Jeson Bulanon', 'Tamlang, Negros Oriental', 2),
('Jonob-Jonob Church', 'Pastor Nicolas Gequilan', 'Jonob-Jonob, Negros Oriental', 3),
('Macasilao Church', 'Pastor Reneboy Beatingo', 'Macasilao, Negros Oriental', 4),
('Dumaguete Church', 'Pastor Joemar Aligato', 'Dumaguete City', 5),
('Udtungan Church', 'Pastor Hernanie Ramos', 'Udtungan, Negros Oriental', 6),
('Old Poblacion Church', 'Pastor Jonadick Maxilom', 'Old Poblacion, Negros Oriental', 7),
('Dian-ay Church', 'Pastor Elmer Balicuatro', 'Dian-ay, Negros Oriental', 8);
