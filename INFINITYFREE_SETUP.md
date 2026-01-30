# InfinityFree Setup Guide for AHFJC Church Website

## Step 1: Create InfinityFree Account
1. Go to: https://infinityfree.net
2. Click "Sign Up Now" (FREE - No Credit Card Required)
3. Choose a subdomain name (e.g., ahfjcchurch.great-site.net)
4. Complete registration

## Step 2: Create MySQL Database
1. Log into InfinityFree Control Panel (VistaPanel)
2. Go to **MySQL Databases**
3. Click "Create Database"
4. Database name: `ahfjcpi` (it will become `epiz_XXXXXXXX_ahfjcpi`)
5. **Save the credentials shown** - you'll need them!

## Step 3: Update Database Configuration
1. Open `config/database.php`
2. Replace the InfinityFree section with YOUR actual credentials:
   ```php
   define('DB_HOST', 'sql000.infinityfree.net');  // From InfinityFree
   define('DB_NAME', 'epiz_XXXXXXXX_ahfjcpi');    // Your actual DB name
   define('DB_USER', 'epiz_XXXXXXXX');             // Your actual username
   define('DB_PASS', 'your_actual_password');      // Your actual password
   ```

## Step 4: Import Database Schema
1. In InfinityFree Control Panel, go to **phpMyAdmin**
2. Select your database from left sidebar
3. Click **Import** tab
4. Choose file: `database/schema.sql`
5. Click **Go** to import

## Step 5: Upload Website Files
### Option A: File Manager (Easy)
1. In Control Panel, go to **File Manager**
2. Navigate to `htdocs` folder
3. Upload all your website files here

### Option B: FTP (Recommended)
1. Download FileZilla: https://filezilla-project.org
2. Get FTP credentials from InfinityFree Control Panel
3. Connect and upload all files to `htdocs` folder

## Step 6: Create Admin User
1. Go to phpMyAdmin in InfinityFree
2. Select your database
3. Click on `admins` table
4. Click **Insert** tab
5. Add admin user:
   - username: `admin`
   - password: (click Function dropdown, select MD5, then type your password)
   - email: your@email.com
   - full_name: Your Name
   - role: `super_admin`
   - is_active: `1`
6. Click **Go**

## Step 7: Test Your Website
1. Visit: http://yoursubdomain.great-site.net
2. Admin login: http://yoursubdomain.great-site.net/admin/login.php
3. Login with the admin credentials you created

## Important Notes

### File Structure on InfinityFree
```
htdocs/
├── index.html
├── admin/
├── api/
├── assets/
├── config/
├── database/
├── includes/
└── ...all other files
```

### Security Reminders
- Change default admin password immediately after first login
- Never share your database credentials
- Keep phpMyAdmin credentials secure

### Free Plan Limits
- Storage: 5GB (plenty for your church site)
- Bandwidth: Unlimited
- Databases: Unlimited MySQL databases
- No time limit - free forever!

### Common Issues

**Problem:** "Database connection failed"
- **Solution:** Double-check credentials in `config/database.php`

**Problem:** "Too many connections"
- **Solution:** InfinityFree limits concurrent connections. Add this to database.php:
  ```php
  $options[PDO::ATTR_PERSISTENT] = false;
  ```

**Problem:** Can't access admin panel
- **Solution:** Make sure you imported the schema and created an admin user

## Upgrading Later (Optional)
- Custom domain: ~$10/year (yourchurch.com)
- Premium hosting: If you outgrow free tier

## Need Help?
- InfinityFree Forum: https://forum.infinityfree.net
- InfinityFree Knowledge Base: https://infinityfree.net/support

---

**You're all set!** Follow these steps and your church website will be live and free! 🎉
