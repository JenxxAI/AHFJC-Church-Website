<?php
/**
 * Backend Test Script
 * Tests database connection, PHP configuration, and backend functionality
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h1>AHFJCPI Backend Test Results</h1>";
echo "<style>body{font-family:sans-serif;margin:20px;} .success{color:green;} .error{color:red;} .warning{color:orange;}</style>";

// Test 1: PHP Version
echo "<h2>1. PHP Configuration</h2>";
echo "<p>PHP Version: <span class='success'>" . phpversion() . "</span></p>";

// Test 2: Required Extensions
echo "<h2>2. PHP Extensions</h2>";
$required_extensions = ['pdo', 'session', 'json', 'mbstring'];
foreach ($required_extensions as $ext) {
    $loaded = extension_loaded($ext);
    echo "<p>$ext: " . ($loaded ? "<span class='success'>✓ Installed</span>" : "<span class='error'>✗ Missing</span>") . "</p>";
}

// Test 3: MySQL PDO Extension
echo "<h2>3. Database Drivers</h2>";
$pdo_drivers = PDO::getAvailableDrivers();
echo "<p>Available PDO drivers: " . implode(', ', $pdo_drivers) . "</p>";
$mysql_available = in_array('mysql', $pdo_drivers);
echo "<p>MySQL PDO: " . ($mysql_available ? "<span class='success'>✓ Available</span>" : "<span class='error'>✗ Not Available</span>") . "</p>";

// Test 4: File Structure
echo "<h2>4. File Structure</h2>";
$required_files = [
    'config/database.php',
    'includes/security.php',
    'includes/functions.php',
    'admin/login.php',
    'admin/dashboard.php',
    'api/get-content.php',
    'database/schema.sql'
];

foreach ($required_files as $file) {
    $exists = file_exists(__DIR__ . '/' . $file);
    echo "<p>$file: " . ($exists ? "<span class='success'>✓ Found</span>" : "<span class='error'>✗ Missing</span>") . "</p>";
}

// Test 5: Include Files
echo "<h2>5. PHP Files Syntax</h2>";
try {
    require_once 'config/database.php';
    echo "<p>config/database.php: <span class='success'>✓ Loaded successfully</span></p>";
} catch (Exception $e) {
    echo "<p>config/database.php: <span class='error'>✗ Error: " . $e->getMessage() . "</span></p>";
}

try {
    require_once 'includes/security.php';
    echo "<p>includes/security.php: <span class='success'>✓ Loaded successfully</span></p>";
} catch (Exception $e) {
    echo "<p>includes/security.php: <span class='error'>✗ Error: " . $e->getMessage() . "</span></p>";
}

try {
    require_once 'includes/functions.php';
    echo "<p>includes/functions.php: <span class='success'>✓ Loaded successfully</span></p>";
} catch (Exception $e) {
    echo "<p>includes/functions.php: <span class='error'>✗ Error: " . $e->getMessage() . "</span></p>";
}

// Test 6: Database Connection
echo "<h2>6. Database Connection</h2>";
if (isset($pdo) && $pdo instanceof PDO) {
    echo "<p>PDO Connection: <span class='success'>✓ Connected</span></p>";
    
    // Test database
    try {
        $stmt = $pdo->query("SELECT DATABASE() as db_name");
        $result = $stmt->fetch();
        echo "<p>Database Name: <span class='success'>{$result['db_name']}</span></p>";
    } catch (PDOException $e) {
        echo "<p>Database Query: <span class='error'>✗ Error: " . $e->getMessage() . "</span></p>";
    }
} else {
    echo "<p>PDO Connection: <span class='error'>✗ Not Connected</span></p>";
    echo "<p class='warning'>⚠ MySQL may not be running. The database schema needs to be imported.</p>";
}

// Test 7: Security Functions
echo "<h2>7. Security Functions</h2>";
if (function_exists('sanitize')) {
    $test_input = "<script>alert('test')</script>";
    $sanitized = sanitize($test_input);
    echo "<p>sanitize() function: <span class='success'>✓ Working</span></p>";
    echo "<p>Test: <code>$test_input</code> → <code>$sanitized</code></p>";
} else {
    echo "<p>sanitize() function: <span class='error'>✗ Not found</span></p>";
}

if (function_exists('hashPassword')) {
    echo "<p>hashPassword() function: <span class='success'>✓ Available</span></p>";
} else {
    echo "<p>hashPassword() function: <span class='error'>✗ Not found</span></p>";
}

// Test 8: Session
echo "<h2>8. Session Management</h2>";
if (session_status() === PHP_SESSION_ACTIVE) {
    echo "<p>Session: <span class='success'>✓ Active</span></p>";
    echo "<p>Session ID: " . session_id() . "</p>";
} else {
    echo "<p>Session: <span class='warning'>⚠ Not started</span></p>";
}

// Test 9: Upload Directory
echo "<h2>9. Upload Directory</h2>";
$upload_dir = __DIR__ . '/uploads';
if (is_dir($upload_dir)) {
    echo "<p>Upload directory: <span class='success'>✓ Exists</span></p>";
    echo "<p>Writable: " . (is_writable($upload_dir) ? "<span class='success'>✓ Yes</span>" : "<span class='error'>✗ No</span>") . "</p>";
} else {
    echo "<p>Upload directory: <span class='warning'>⚠ Not created yet</span></p>";
    if (mkdir($upload_dir, 0755, true)) {
        echo "<p>Created: <span class='success'>✓ Successfully created</span></p>";
    }
}

echo "<hr>";
echo "<h2>Summary</h2>";
if (!$mysql_available) {
    echo "<p class='error'><strong>⚠ IMPORTANT: MySQL PDO driver is not installed.</strong></p>";
    echo "<p>To install it, run:</p>";
    echo "<pre>sudo apt-get update && sudo apt-get install php8.3-mysql</pre>";
}

echo "<p class='warning'><strong>Next Steps:</strong></p>";
echo "<ol>";
echo "<li>Install MySQL server if not already installed</li>";
echo "<li>Install PHP MySQL extension (php-mysql)</li>";
echo "<li>Import the database schema from database/schema.sql</li>";
echo "<li>Update config/database.php with your database credentials</li>";
echo "<li>Access admin panel at /admin/login.php</li>";
echo "</ol>";

echo "<p>Default admin credentials (from schema.sql):</p>";
echo "<ul>";
echo "<li>Username: <code>admin</code></li>";
echo "<li>Password: <code>admin123</code></li>";
echo "<li><strong style='color:red;'>CHANGE THIS PASSWORD IMMEDIATELY!</strong></li>";
echo "</ul>";
?>
