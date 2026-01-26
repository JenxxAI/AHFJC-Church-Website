<?php
require_once '../config/database.php';
require_once '../includes/security.php';

// Redirect if already logged in
if (isLoggedIn()) {
    header('Location: dashboard.php');
    exit();
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = sanitize($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    // Rate limiting
    if (!checkRateLimit('login_' . $_SERVER['REMOTE_ADDR'])) {
        $error = 'Too many login attempts. Please try again in 15 minutes.';
    } else {
        if (empty($username) || empty($password)) {
            $error = 'Please enter username and password';
        } else {
            // Query admin user
            $stmt = $pdo->prepare("SELECT * FROM admins WHERE username = ? AND is_active = 1");
            $stmt->execute([$username]);
            $admin = $stmt->fetch();
            
            if ($admin && verifyPassword($password, $admin['password'])) {
                // Successful login
                $_SESSION['admin_id'] = $admin['id'];
                $_SESSION['admin_username'] = $admin['username'];
                $_SESSION['admin_role'] = $admin['role'];
                $_SESSION['admin_name'] = $admin['full_name'];
                
                // Update last login
                $pdo->prepare("UPDATE admins SET last_login = NOW() WHERE id = ?")
                    ->execute([$admin['id']]);
                
                // Log activity
                logActivity($pdo, $admin['id'], 'login', 'Successful login');
                
                redirect('dashboard.php', 'Welcome back, ' . $admin['full_name'] . '!');
            } else {
                $error = 'Invalid username or password';
            }
        }
    }
}

$csrf_token = generateCSRFToken();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - AHFJCPI</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .login-container {
            background: white;
            padding: 3rem;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .logo {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .logo h1 {
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 4px;
            margin-bottom: 0.5rem;
        }
        
        .logo p {
            color: #666;
            font-size: 0.9rem;
            font-weight: 300;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 400;
            font-size: 0.9rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #e5e5e5;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #1a1a1a;
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            border-left: 3px solid #c33;
        }
        
        .btn {
            width: 100%;
            background: #1a1a1a;
            color: white;
            padding: 1rem;
            border: none;
            font-size: 1rem;
            font-weight: 400;
            letter-spacing: 1px;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
        
        .footer {
            text-align: center;
            margin-top: 2rem;
            color: #999;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <h1>AHFJCPI</h1>
            <p>Admin Panel</p>
        </div>
        
        <?php if ($error): ?>
            <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>
        
        <form method="POST" action="">
            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
            
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn">LOGIN</button>
        </form>
        
        <div class="footer">
            <p>&copy; 2026 AHFJCPI. All rights reserved.</p>
            <p>Default login: admin / admin123</p>
        </div>
    </div>
</body>
</html>