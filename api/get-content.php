<?php
/**
 * API to fetch content for frontend
 */
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$type = $_GET['type'] ?? '';
$id = isset($_GET['id']) ? (int)$_GET['id'] : null;

try {
    $response = ['success' => false, 'data' => null];
    
    switch ($type) {
        case 'churches':
            if ($id) {
                $stmt = $pdo->prepare("SELECT * FROM churches WHERE id = ? AND is_active = 1");
                $stmt->execute([$id]);
                $response['data'] = $stmt->fetch();
            } else {
                $stmt = $pdo->query("SELECT * FROM churches WHERE is_active = 1 ORDER BY display_order, church_name");
                $response['data'] = $stmt->fetchAll();
            }
            $response['success'] = true;
            break;
            
        case 'events':
            $upcoming = isset($_GET['upcoming']) && $_GET['upcoming'] === 'true';
            if ($id) {
                $stmt = $pdo->prepare("SELECT e.*, c.church_name FROM events e LEFT JOIN churches c ON e.church_id = c.id WHERE e.id = ? AND e.is_active = 1");
                $stmt->execute([$id]);
                $response['data'] = $stmt->fetch();
            } elseif ($upcoming) {
                $stmt = $pdo->query("SELECT e.*, c.church_name FROM events e LEFT JOIN churches c ON e.church_id = c.id WHERE e.event_date >= CURDATE() AND e.is_active = 1 ORDER BY e.event_date ASC LIMIT 10");
                $response['data'] = $stmt->fetchAll();
            } else {
                $stmt = $pdo->query("SELECT e.*, c.church_name FROM events e LEFT JOIN churches c ON e.church_id = c.id WHERE e.is_active = 1 ORDER BY e.event_date DESC");
                $response['data'] = $stmt->fetchAll();
            }
            $response['success'] = true;
            break;
            
        case 'leadership':
            $stmt = $pdo->query("SELECT * FROM leadership WHERE is_active = 1 ORDER BY display_order, position");
            $response['data'] = $stmt->fetchAll();
            $response['success'] = true;
            break;
            
        case 'ministry':
            $category = $_GET['category'] ?? null;
            if ($category) {
                $stmt = $pdo->prepare("SELECT m.*, c.church_name FROM ministry_posts m LEFT JOIN churches c ON m.church_id = c.id WHERE m.category = ? AND m.is_active = 1 ORDER BY m.post_date DESC");
                $stmt->execute([$category]);
            } else {
                $stmt = $pdo->query("SELECT m.*, c.church_name FROM ministry_posts m LEFT JOIN churches c ON m.church_id = c.id WHERE m.is_active = 1 ORDER BY m.post_date DESC");
            }
            $response['data'] = $stmt->fetchAll();
            $response['success'] = true;
            break;
            
        case 'testimonies':
            $featured = isset($_GET['featured']) && $_GET['featured'] === 'true';
            if ($featured) {
                $stmt = $pdo->query("SELECT t.*, c.church_name FROM testimonies t LEFT JOIN churches c ON t.church_id = c.id WHERE t.is_approved = 1 AND t.is_featured = 1 ORDER BY t.created_at DESC LIMIT 5");
            } else {
                $stmt = $pdo->query("SELECT t.*, c.church_name FROM testimonies t LEFT JOIN churches c ON t.church_id = c.id WHERE t.is_approved = 1 ORDER BY t.created_at DESC");
            }
            $response['data'] = $stmt->fetchAll();
            $response['success'] = true;
            break;
            
        case 'resources':
            $resource_type = $_GET['resource_type'] ?? null;
            if ($resource_type) {
                $stmt = $pdo->prepare("SELECT * FROM resources WHERE resource_type = ? AND is_active = 1 ORDER BY created_at DESC");
                $stmt->execute([$resource_type]);
            } else {
                $stmt = $pdo->query("SELECT * FROM resources WHERE is_active = 1 ORDER BY created_at DESC");
            }
            $response['data'] = $stmt->fetchAll();
            $response['success'] = true;
            break;
            
        case 'submit_prayer':
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $data = json_decode(file_get_contents('php://input'), true);
                
                $name = htmlspecialchars(trim($data['name'] ?? ''));
                $email = htmlspecialchars(trim($data['email'] ?? ''));
                $phone = htmlspecialchars(trim($data['phone'] ?? ''));
                $request = htmlspecialchars(trim($data['request'] ?? ''));
                
                if (empty($name) || empty($request)) {
                    $response['error'] = 'Name and prayer request are required';
                } else {
                    $stmt = $pdo->prepare("INSERT INTO prayer_requests (name, email, phone, request) VALUES (?, ?, ?, ?)");
                    $stmt->execute([$name, $email, $phone, $request]);
                    $response['success'] = true;
                    $response['message'] = 'Prayer request submitted successfully';
                }
            }
            break;
            
        case 'submit_testimony':
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $data = json_decode(file_get_contents('php://input'), true);
                
                $author_name = htmlspecialchars(trim($data['author_name'] ?? ''));
                $church_id = !empty($data['church_id']) ? (int)$data['church_id'] : null;
                $testimony = htmlspecialchars(trim($data['testimony'] ?? ''));
                
                if (empty($author_name) || empty($testimony)) {
                    $response['error'] = 'Name and testimony are required';
                } else {
                    $stmt = $pdo->prepare("INSERT INTO testimonies (author_name, church_id, testimony) VALUES (?, ?, ?)");
                    $stmt->execute([$author_name, $church_id, $testimony]);
                    $response['success'] = true;
                    $response['message'] = 'Testimony submitted and pending approval';
                }
            }
            break;
            
        case 'stats':
            $stats = [];
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM churches WHERE is_active = 1");
            $stats['total_churches'] = $stmt->fetch()['count'];
            
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM events WHERE event_date >= CURDATE() AND is_active = 1");
            $stats['upcoming_events'] = $stmt->fetch()['count'];
            
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM testimonies WHERE is_approved = 1");
            $stats['total_testimonies'] = $stmt->fetch()['count'];
            
            $response['data'] = $stats;
            $response['success'] = true;
            break;
            
        default:
            $response['error'] = 'Invalid request type';
    }
    
    echo json_encode($response);
    
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'error' => 'Database error occurred'
    ]);
}
?>
