<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Prayer Requests';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('prayer-requests.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    $id = (int)$_POST['id'];
    
    if ($action === 'mark_answered') {
        $stmt = $pdo->prepare("UPDATE prayer_requests SET is_answered = 1 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('prayer-requests.php', 'Marked as answered');
    } elseif ($action === 'mark_unanswered') {
        $stmt = $pdo->prepare("UPDATE prayer_requests SET is_answered = 0 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('prayer-requests.php', 'Marked as unanswered');
    } elseif ($action === 'toggle_public') {
        $stmt = $pdo->prepare("UPDATE prayer_requests SET is_public = NOT is_public WHERE id = ?");
        $stmt->execute([$id]);
        redirect('prayer-requests.php', 'Privacy updated');
    } elseif ($action === 'delete') {
        $stmt = $pdo->prepare("DELETE FROM prayer_requests WHERE id = ?");
        $stmt->execute([$id]);
        redirect('prayer-requests.php', 'Prayer request deleted');
    }
}

// Get all prayer requests
$filter = $_GET['filter'] ?? 'all';
$sql = "SELECT * FROM prayer_requests";
if ($filter === 'answered') {
    $sql .= " WHERE is_answered = 1";
} elseif ($filter === 'unanswered') {
    $sql .= " WHERE is_answered = 0";
}
$sql .= " ORDER BY submitted_at DESC";

$stmt = $pdo->query($sql);
$prayers = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="prayers-page">
    <h1>Prayer Requests</h1>
    
    <div style="margin-bottom: 1rem;">
        <a href="?filter=all" class="btn <?= $filter === 'all' ? 'btn-success' : 'btn-secondary' ?>">All</a>
        <a href="?filter=unanswered" class="btn <?= $filter === 'unanswered' ? 'btn-success' : 'btn-secondary' ?>">Unanswered</a>
        <a href="?filter=answered" class="btn <?= $filter === 'answered' ? 'btn-success' : 'btn-secondary' ?>">Answered</a>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Contact</th>
                <th>Request</th>
                <th>Submitted</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($prayers)): ?>
            <tr>
                <td colspan="6" style="text-align:center;">No prayer requests found.</td>
            </tr>
            <?php else: ?>
            <?php foreach ($prayers as $prayer): ?>
            <tr>
                <td><?= htmlspecialchars($prayer['name']) ?></td>
                <td>
                    <?php if ($prayer['email']): ?>
                        <?= htmlspecialchars($prayer['email']) ?><br>
                    <?php endif; ?>
                    <?= htmlspecialchars($prayer['phone']) ?>
                </td>
                <td><?= truncate(htmlspecialchars($prayer['request']), 100) ?></td>
                <td><?= timeAgo($prayer['submitted_at']) ?></td>
                <td>
                    <?php if ($prayer['is_answered']): ?>
                        <span class="badge badge-success">Answered</span>
                    <?php else: ?>
                        <span class="badge badge-warning">Pending</span>
                    <?php endif; ?>
                    <?php if ($prayer['is_public']): ?>
                        <span class="badge badge-info">Public</span>
                    <?php endif; ?>
                </td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='viewPrayer(<?= json_encode($prayer) ?>)'>View</button>
                        
                        <?php if (!$prayer['is_answered']): ?>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                                <input type="hidden" name="action" value="mark_answered">
                                <input type="hidden" name="id" value="<?= $prayer['id'] ?>">
                                <button type="submit" class="btn btn-success">Mark Answered</button>
                            </form>
                        <?php else: ?>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                                <input type="hidden" name="action" value="mark_unanswered">
                                <input type="hidden" name="id" value="<?= $prayer['id'] ?>">
                                <button type="submit" class="btn btn-secondary">Mark Unanswered</button>
                            </form>
                        <?php endif; ?>
                        
                        <form method="POST" style="display:inline;">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="toggle_public">
                            <input type="hidden" name="id" value="<?= $prayer['id'] ?>">
                            <button type="submit" class="btn btn-secondary"><?= $prayer['is_public'] ? 'Make Private' : 'Make Public' ?></button>
                        </form>
                        
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this prayer request?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $prayer['id'] ?>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<!-- View Modal -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <h2>Prayer Request Details</h2>
        <div id="prayerContent"></div>
        <button class="btn btn-secondary" onclick="closeViewModal()">Close</button>
    </div>
</div>

<script>
function viewPrayer(prayer) {
    const content = `
        <p><strong>Name:</strong> ${prayer.name}</p>
        <p><strong>Email:</strong> ${prayer.email || '-'}</p>
        <p><strong>Phone:</strong> ${prayer.phone || '-'}</p>
        <p><strong>Submitted:</strong> ${prayer.submitted_at}</p>
        <p><strong>Status:</strong> ${prayer.is_answered ? 'Answered' : 'Pending'}</p>
        <p><strong>Privacy:</strong> ${prayer.is_public ? 'Public' : 'Private'}</p>
        <hr>
        <p><strong>Prayer Request:</strong></p>
        <p>${prayer.request}</p>
    `;
    document.getElementById('prayerContent').innerHTML = content;
    document.getElementById('viewModal').classList.add('active');
}

function closeViewModal() {
    document.getElementById('viewModal').classList.remove('active');
}

document.getElementById('viewModal').addEventListener('click', function(e) {
    if (e.target === this) closeViewModal();
});
</script>

<?php include '../includes/admin-footer.php'; ?>
