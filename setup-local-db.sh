#!/bin/bash
# Local MySQL Setup Script for AHFJC Church Website

echo "=================================="
echo "Local MySQL Database Setup"
echo "=================================="

# Check if MySQL is installed
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL is not installed"
    echo ""
    echo "To install MySQL, run:"
    echo "  sudo apt update"
    echo "  sudo apt install mysql-server -y"
    exit 1
fi

echo "✅ MySQL is installed"

# Start MySQL service
echo "Starting MySQL service..."
sudo service mysql start 2>/dev/null || sudo /etc/init.d/mysql start 2>/dev/null

# Check if MySQL is running
if sudo service mysql status | grep -q "running\|active"; then
    echo "✅ MySQL is running"
else
    echo "⚠️  MySQL may not be running. Trying to start..."
fi

# Create database and import schema
echo ""
echo "Creating database and importing schema..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ahfjcpi_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Database 'ahfjcpi_db' created"
    
    # Import schema
    mysql -u root ahfjcpi_db < database/schema.sql 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Schema imported successfully"
        echo ""
        echo "=================================="
        echo "Setup Complete!"
        echo "=================================="
        echo ""
        echo "Admin Login Credentials:"
        echo "  Username: admin"
        echo "  Password: admin123"
        echo ""
        echo "Test your admin panel at:"
        echo "  http://localhost:8000/admin/login.php"
        echo ""
    else
        echo "❌ Failed to import schema"
    fi
else
    echo "❌ Failed to create database"
    echo ""
    echo "You may need to set a root password:"
    echo "  sudo mysql"
    echo "  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"
    echo "  FLUSH PRIVILEGES;"
    echo "  EXIT;"
fi
