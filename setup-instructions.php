<?php
/**
 * Database Status and Setup Instructions
 */
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Setup - AHFJC Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { color: #333; }
        .status { padding: 15px; margin: 15px 0; border-radius: 5px; }
        .error { background: #ffe6e6; border-left: 4px solid #ff0000; }
        .success { background: #e6ffe6; border-left: 4px solid #00cc00; }
        .info { background: #e6f3ff; border-left: 4px solid #0066cc; }
        code {
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: monospace;
        }
        pre {
            background: #2d2d2d;
            color: #fff;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }
        .step {
            margin: 20px 0;
            padding: 15px;
            background: #f9f9f9;
            border-left: 3px solid #0066cc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Database Setup Required</h1>
        
        <?php
        // Test database connection
        $isProduction = (strpos($_SERVER['HTTP_HOST'] ?? '', 'infinityfree') !== false);
        
        if ($isProduction) {
            echo '<div class="status info">';
            echo '<strong>📍 Environment:</strong> Production (InfinityFree)<br>';
            echo '<strong>Database:</strong> if0_41033448_ahfjcpi<br>';
            echo '<strong>Host:</strong> sql210.infinityfree.com';
            echo '</div>';
            echo '<p>✅ Your InfinityFree database is configured and ready!</p>';
        } else {
            echo '<div class="status error">';
            echo '<strong>📍 Environment:</strong> Local Development<br>';
            echo '<strong>Database:</strong> ahfjcpi_db (not set up yet)<br>';
            echo '<strong>Host:</strong> localhost';
            echo '</div>';
            
            // Check if we can connect
            try {
                $pdo = new PDO("mysql:host=localhost", "root", "");
                echo '<div class="status success">';
                echo '✅ MySQL is running on your computer!';
                echo '</div>';
                
                // Check if database exists
                $stmt = $pdo->query("SHOW DATABASES LIKE 'ahfjcpi_db'");
                if ($stmt->rowCount() > 0) {
                    echo '<div class="status success">';
                    echo '✅ Database "ahfjcpi_db" exists!';
                    echo '</div>';
                    echo '<p>Try refreshing the admin page. If it still doesn\'t work, the tables might be missing.</p>';
                } else {
                    echo '<div class="status error">';
                    echo '❌ Database "ahfjcpi_db" does not exist';
                    echo '</div>';
                }
            } catch (PDOException $e) {
                echo '<div class="status error">';
                echo '❌ Cannot connect to MySQL: ' . htmlspecialchars($e->getMessage());
                echo '</div>';
            }
        }
        ?>
        
        <h2>🚀 Quick Setup for Local Testing</h2>
        
        <div class="step">
            <h3>Step 1: Start MySQL</h3>
            <p>Open a terminal and run:</p>
            <pre>sudo service mysql start</pre>
        </div>
        
        <div class="step">
            <h3>Step 2: Create Database & Import Schema</h3>
            <p>Run these commands:</p>
            <pre>mysql -u root -e "CREATE DATABASE IF NOT EXISTS ahfjcpi_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root ahfjcpi_db &lt; database/schema.sql</pre>
        </div>
        
        <div class="step">
            <h3>Step 3: Test Admin Login</h3>
            <p>After setup, login with:</p>
            <ul>
                <li><strong>Username:</strong> <code>admin</code></li>
                <li><strong>Password:</strong> <code>admin123</code></li>
            </ul>
            <a href="/admin/login.php" style="display: inline-block; padding: 10px 20px; background: #0066cc; color: white; text-decoration: none; border-radius: 5px; margin-top: 10px;">Go to Admin Login</a>
        </div>
        
        <div class="status info">
            <h3>💡 Alternative: Test on InfinityFree Directly</h3>
            <p>If you don't want to set up local MySQL, you can:</p>
            <ol>
                <li>Upload your website files to InfinityFree now</li>
                <li>Test the admin panel there</li>
                <li>The database is already set up and working!</li>
            </ol>
        </div>
        
        <hr style="margin: 30px 0;">
        
        <div class="status info">
            <strong>📝 Note:</strong> When you upload to InfinityFree, the code automatically switches to use the InfinityFree database. No changes needed!
        </div>
    </div>
</body>
</html>
