<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();

$page_title = 'Dashboard';

// Get statistics
$stats = [];

// Total churches
$stmt = $pdo->query("SELECT COUNT(*) as count FROM churches WHERE is_active = 1");
$stats['churches'] = $stmt->fetch()['count'];

// Total events
$stmt = $pdo->query("SELECT COUNT(*) as count FROM events WHERE is_active = 1");
$stats['events'] = $stmt->fetch()['count'];

// Upcoming events
$stmt = $pdo->query("SELECT COUNT(*) as count FROM events WHERE event_date >= CURDATE() AND is_active = 1");
$stats['upcoming_events'] = $stmt->fetch()['count'];

// Total testimonies
$stmt = $pdo->query("SELECT COUNT(*) as count FROM testimonies WHERE is_approved = 1");
$stats['testimonies'] = $stmt->fetch()['count'];

// Pending testimonies
$stmt = $pdo->query("SELECT COUNT(*) as count FROM testimonies WHERE is_approved = 0");
$stats['pending_testimonies'] = $stmt->fetch()['count'];

// Prayer requests
$stmt = $pdo->query("SELECT COUNT(*) as count FROM prayer_requests WHERE is_answered = 0");
$stats['prayer_requests'] = $stmt->fetch()['count'];

// Recent events
$stmt = $pdo->query("SELECT * FROM events WHERE is_active = 1 ORDER BY event_date DESC LIMIT 5");
$recent_events = $stmt->fetchAll();

// Recent prayer requests
$stmt = $pdo->query("SELECT * FROM prayer_requests ORDER BY submitted_at DESC LIMIT 5");
$recent_prayers = $stmt->fetchAll();

include '../includes/admin-header.php';
?>

<div class="dashboard">
    <h1>Dashboard</h1>
    <p>Welcome back, <?= htmlspecialchars($_SESSION['admin_name']) ?>!</p>
    
    <div class="stats-grid">
        <div class="stat-card">
            <h3><?= $stats['churches'] ?></h3>
            <p>Active Churches</p>
            <a href="churches.php">Manage &rarr;</a>
        </div>
        
        <div class="stat-card">
            <h3><?= $stats['upcoming_events'] ?></h3>
            <p>Upcoming Events</p>
            <a href="events.php">Manage &rarr;</a>
        </div>
        
        <div class="stat-card">
            <h3><?= $stats['pending_testimonies'] ?></h3>
            <p>Pending Testimonies</p>
            <a href="testimonies.php">Review &rarr;</a>
        </div>
        
        <div class="stat-card">
            <h3><?= $stats['prayer_requests'] ?></h3>
            <p>Prayer Requests</p>
            <a href="prayer-requests.php">View &rarr;</a>
        </div>
    </div>
    
    <div class="dashboard-grid">
        <div class="dashboard-section">
            <h2>Recent Events</h2>
            <?php if (empty($recent_events)): ?>
                <p>No events found.</p>
            <?php else: ?>
                <table>
                    <thead>
                        <tr>
                            <th>Event</th>
                            <th>Date</th>
                            <th>Location</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($recent_events as $event): ?>
                        <tr>
                            <td><?= htmlspecialchars($event['event_title']) ?></td>
                            <td><?= formatDate($event['event_date']) ?></td>
                            <td><?= htmlspecialchars($event['location']) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
        
        <div class="dashboard-section">
            <h2>Recent Prayer Requests</h2>
            <?php if (empty($recent_prayers)): ?>
                <p>No prayer requests found.</p>
            <?php else: ?>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Submitted</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($recent_prayers as $prayer): ?>
                        <tr>
                            <td><?= htmlspecialchars($prayer['name']) ?></td>
                            <td><?= timeAgo($prayer['submitted_at']) ?></td>
                            <td><?= $prayer['is_answered'] ? '✓ Answered' : 'Pending' ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
    </div>
</div>

<?php include '../includes/admin-footer.php'; ?>
