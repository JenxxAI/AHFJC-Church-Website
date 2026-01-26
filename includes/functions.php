<?php
/**
 * Helper Functions
 * Reusable utility functions for the application
 */

/**
 * Format date for display
 */
function formatDate($date, $format = 'F j, Y') {
    if (!$date) return '';
    return date($format, strtotime($date));
}

/**
 * Format datetime for display
 */
function formatDateTime($datetime, $format = 'F j, Y g:i A') {
    if (!$datetime) return '';
    return date($format, strtotime($datetime));
}

/**
 * Get time ago
 */
function timeAgo($datetime) {
    $timestamp = strtotime($datetime);
    $diff = time() - $timestamp;
    
    if ($diff < 60) return $diff . ' seconds ago';
    if ($diff < 3600) return floor($diff / 60) . ' minutes ago';
    if ($diff < 86400) return floor($diff / 3600) . ' hours ago';
    if ($diff < 604800) return floor($diff / 86400) . ' days ago';
    if ($diff < 2592000) return floor($diff / 604800) . ' weeks ago';
    return formatDate($datetime);
}

/**
 * Truncate text
 */
function truncate($text, $length = 100, $suffix = '...') {
    if (strlen($text) <= $length) return $text;
    return substr($text, 0, $length) . $suffix;
}

/**
 * Get pagination HTML
 */
function getPagination($current_page, $total_pages, $base_url) {
    if ($total_pages <= 1) return '';
    
    $html = '<div class="pagination">';
    
    // Previous
    if ($current_page > 1) {
        $html .= '<a href="' . $base_url . '?page=' . ($current_page - 1) . '">&laquo; Previous</a>';
    }
    
    // Pages
    for ($i = 1; $i <= $total_pages; $i++) {
        if ($i == $current_page) {
            $html .= '<span class="active">' . $i . '</span>';
        } else {
            $html .= '<a href="' . $base_url . '?page=' . $i . '">' . $i . '</a>';
        }
    }
    
    // Next
    if ($current_page < $total_pages) {
        $html .= '<a href="' . $base_url . '?page=' . ($current_page + 1) . '">Next &raquo;</a>';
    }
    
    $html .= '</div>';
    return $html;
}

/**
 * Upload image file
 */
function uploadImage($file, $upload_dir = null) {
    if (!$upload_dir) {
        $upload_dir = UPLOAD_PATH;
    }
    
    // Create directory if it doesn't exist
    if (!is_dir($upload_dir)) {
        mkdir($upload_dir, 0755, true);
    }
    
    // Validate
    $errors = validateImageUpload($file);
    if (!empty($errors)) {
        return ['success' => false, 'errors' => $errors];
    }
    
    // Generate filename
    $filename = generateFilename($file['name']);
    $filepath = $upload_dir . $filename;
    
    // Move file
    if (move_uploaded_file($file['tmp_name'], $filepath)) {
        return ['success' => true, 'filename' => $filename, 'path' => $filepath];
    }
    
    return ['success' => false, 'errors' => ['Upload failed']];
}

/**
 * Delete file
 */
function deleteFile($filepath) {
    if (file_exists($filepath)) {
        return unlink($filepath);
    }
    return true;
}

/**
 * Get admin info
 */
function getAdminInfo($pdo, $admin_id) {
    $stmt = $pdo->prepare("SELECT * FROM admins WHERE id = ?");
    $stmt->execute([$admin_id]);
    return $stmt->fetch();
}

/**
 * Check if admin has permission
 */
function checkPermission($required_role) {
    requireLogin();
    if (!hasRole($required_role)) {
        redirect('dashboard.php', 'You do not have permission to perform this action.', 'error');
    }
}

/**
 * Get status badge HTML
 */
function getStatusBadge($is_active) {
    if ($is_active) {
        return '<span class="badge badge-success">Active</span>';
    }
    return '<span class="badge badge-danger">Inactive</span>';
}

/**
 * Get role badge HTML
 */
function getRoleBadge($role) {
    $badges = [
        'super_admin' => '<span class="badge badge-danger">Super Admin</span>',
        'admin' => '<span class="badge badge-warning">Admin</span>',
        'editor' => '<span class="badge badge-info">Editor</span>'
    ];
    return $badges[$role] ?? '<span class="badge badge-secondary">' . $role . '</span>';
}
?>
