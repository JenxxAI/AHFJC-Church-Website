<?php
/**
 * Test InfinityFree Database Connection
 * This file tests if your database credentials are correct
 */

// Database credentials
$host = 'sql210.infinityfree.com';
$dbname = 'if0_41033448_ahfjcpi';
$username = 'if0_41033448';
$password = 'Cmtorres1324';

echo "<h1>InfinityFree Database Connection Test</h1>";

try {
    // Attempt connection
    $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
    
    echo "<p style='color: green; font-size: 18px;'>✅ <strong>SUCCESS!</strong> Connected to InfinityFree database!</p>";
    
    // Test admin table
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM admins");
    $result = $stmt->fetch();
    echo "<p>👤 Admin users found: <strong>{$result['count']}</strong></p>";
    
    // Test churches table
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM churches");
    $result = $stmt->fetch();
    echo "<p>⛪ Churches found: <strong>{$result['count']}</strong></p>";
    
    // Test leadership table
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM leadership");
    $result = $stmt->fetch();
    echo "<p>👔 Leadership entries: <strong>{$result['count']}</strong></p>";
    
    // Get admin details
    echo "<h2>Admin Account Details:</h2>";
    $stmt = $pdo->query("SELECT username, email, full_name, role FROM admins LIMIT 1");
    $admin = $stmt->fetch();
    
    if ($admin) {
        echo "<ul>";
        echo "<li><strong>Username:</strong> {$admin['username']}</li>";
        echo "<li><strong>Email:</strong> {$admin['email']}</li>";
        echo "<li><strong>Full Name:</strong> {$admin['full_name']}</li>";
        echo "<li><strong>Role:</strong> {$admin['role']}</li>";
        echo "</ul>";
        echo "<p style='background: #ffffcc; padding: 10px; border-left: 4px solid orange;'>";
        echo "🔐 <strong>Default Password:</strong> admin123<br>";
        echo "⚠️ Change this password immediately after first login!";
        echo "</p>";
    }
    
    echo "<h2>✅ Your Database is Ready!</h2>";
    echo "<p>You can now:</p>";
    echo "<ul>";
    echo "<li>Login to admin panel: <a href='/admin/login.php'>/admin/login.php</a></li>";
    echo "<li>Continue developing your website</li>";
    echo "<li>Upload files to InfinityFree when ready</li>";
    echo "</ul>";
    
} catch (PDOException $e) {
    echo "<p style='color: red; font-size: 18px;'>❌ <strong>CONNECTION FAILED</strong></p>";
    echo "<p><strong>Error:</strong> " . htmlspecialchars($e->getMessage()) . "</p>";
    
    echo "<h3>Common Issues:</h3>";
    echo "<ul>";
    echo "<li>Check if database credentials in config/database.php are correct</li>";
    echo "<li>Make sure you imported schema.sql in phpMyAdmin</li>";
    echo "<li>Verify database exists in InfinityFree Control Panel</li>";
    echo "</ul>";
}
?>
