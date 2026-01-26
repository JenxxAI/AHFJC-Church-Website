<?php
/**
 * Test Database Connection
 */
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h2>Database Connection Test</h2>";
echo "<style>body{font-family:sans-serif;margin:20px;} .success{color:green;} .error{color:red;} .info{color:blue;}</style>";

// Check if PDO MySQL is available
echo "<h3>1. PDO MySQL Extension</h3>";
$pdo_mysql_loaded = extension_loaded('pdo_mysql');
if ($pdo_mysql_loaded) {
    echo "<p class='success'>✓ PDO MySQL extension is loaded</p>";
} else {
    echo "<p class='error'>✗ PDO MySQL extension is NOT loaded</p>";
    echo "<p class='info'>Available PDO drivers: " . implode(', ', PDO::getAvailableDrivers()) . "</p>";
    echo "<hr>";
    echo "<h3>Solution:</h3>";
    echo "<p>Install the PHP MySQL extension:</p>";
    echo "<pre>sudo apt-get update\nsudo apt-get install php8.3-mysql -y\nsudo service php8.3-fpm restart</pre>";
    exit;
}

// Try to load database config
echo "<h3>2. Database Configuration</h3>";
try {
    require_once __DIR__ . '/config/database.php';
    echo "<p class='success'>✓ Database config loaded</p>";
    echo "<p class='info'>Host: " . DB_HOST . "</p>";
    echo "<p class='info'>Database: " . DB_NAME . "</p>";
    echo "<p class='info'>User: " . DB_USER . "</p>";
} catch (Exception $e) {
    echo "<p class='error'>✗ Error loading config: " . $e->getMessage() . "</p>";
    exit;
}

// Test connection
echo "<h3>3. Database Connection</h3>";
if (isset($pdo) && $pdo instanceof PDO) {
    echo "<p class='success'>✓ Successfully connected to database!</p>";
    
    // Get database info
    try {
        $stmt = $pdo->query("SELECT DATABASE() as db, VERSION() as version");
        $info = $stmt->fetch();
        echo "<p class='success'>Database: {$info['db']}</p>";
        echo "<p class='success'>MySQL Version: {$info['version']}</p>";
        
        // Check tables
        echo "<h3>4. Database Tables</h3>";
        $stmt = $pdo->query("SHOW TABLES");
        $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
        
        if (count($tables) > 0) {
            echo "<p class='success'>✓ Found " . count($tables) . " tables:</p>";
            echo "<ul>";
            foreach ($tables as $table) {
                echo "<li>$table</li>";
            }
            echo "</ul>";
            
            // Count records in key tables
            echo "<h3>5. Table Records</h3>";
            $check_tables = ['admins', 'churches', 'leadership', 'events'];
            foreach ($check_tables as $table) {
                if (in_array($table, $tables)) {
                    $stmt = $pdo->query("SELECT COUNT(*) as count FROM `$table`");
                    $count = $stmt->fetch()['count'];
                    echo "<p>$table: <span class='info'>$count records</span></p>";
                }
            }
        } else {
            echo "<p class='error'>✗ No tables found! Database schema not imported.</p>";
            echo "<p>Import the schema:</p>";
            echo "<pre>mysql -u root -p ahfjcpi_db < database/schema.sql</pre>";
        }
        
    } catch (PDOException $e) {
        echo "<p class='error'>✗ Query error: " . $e->getMessage() . "</p>";
    }
    
} else {
    echo "<p class='error'>✗ Failed to connect to database</p>";
    echo "<p>Possible issues:</p>";
    echo "<ul>";
    echo "<li>MySQL server is not running</li>";
    echo "<li>Database 'ahfjcpi_db' does not exist</li>";
    echo "<li>Wrong credentials in config/database.php</li>";
    echo "</ul>";
    
    echo "<h3>Setup Steps:</h3>";
    echo "<ol>";
    echo "<li>Install MySQL server:<br><code>sudo apt-get install mysql-server -y</code></li>";
    echo "<li>Start MySQL:<br><code>sudo service mysql start</code></li>";
    echo "<li>Create database and import schema:<br><code>sudo mysql -u root < database/schema.sql</code></li>";
    echo "</ol>";
}
?>
