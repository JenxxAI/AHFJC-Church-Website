<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Manage Testimonies';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('testimonies.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    $id = (int)$_POST['id'];
    
    if ($action === 'approve') {
        $stmt = $pdo->prepare("UPDATE testimonies SET is_approved = 1 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('testimonies.php', 'Testimony approved');
    } elseif ($action === 'unapprove') {
        $stmt = $pdo->prepare("UPDATE testimonies SET is_approved = 0 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('testimonies.php', 'Testimony unapproved');
    } elseif ($action === 'feature') {
        $stmt = $pdo->prepare("UPDATE testimonies SET is_featured = 1 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('testimonies.php', 'Testimony featured');
    } elseif ($action === 'unfeature') {
        $stmt = $pdo->prepare("UPDATE testimonies SET is_featured = 0 WHERE id = ?");
        $stmt->execute([$id]);
        redirect('testimonies.php', 'Testimony unfeatured');
    } elseif ($action === 'delete') {
        $stmt = $pdo->prepare("DELETE FROM testimonies WHERE id = ?");
        $stmt->execute([$id]);
        redirect('testimonies.php', 'Testimony deleted');
    }
}

// Get all testimonies
$stmt = $pdo->query("SELECT t.*, c.church_name FROM testimonies t LEFT JOIN churches c ON t.church_id = c.id ORDER BY t.created_at DESC");
$testimonies = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="testimonies-page">
    <h1>Manage Testimonies</h1>
    
    <table>
        <thead>
            <tr>
                <th>Author</th>
                <th>Church</th>
                <th>Testimony</th>
                <th>Submitted</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($testimonies as $testimony): ?>
            <tr>
                <td><?= htmlspecialchars($testimony['author_name']) ?></td>
                <td><?= htmlspecialchars($testimony['church_name'] ?? '-') ?></td>
                <td><?= truncate(htmlspecialchars($testimony['testimony']), 150) ?></td>
                <td><?= timeAgo($testimony['created_at']) ?></td>
                <td>
                    <?php if ($testimony['is_approved']): ?>
                        <span class="badge badge-success">Approved</span>
                    <?php else: ?>
                        <span class="badge badge-warning">Pending</span>
                    <?php endif; ?>
                    <?php if ($testimony['is_featured']): ?>
                        <span class="badge badge-info">Featured</span>
                    <?php endif; ?>
                </td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='viewTestimony(<?= json_encode($testimony) ?>)'>View</button>
                        
                        <?php if (!$testimony['is_approved']): ?>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="id" value="<?= $testimony['id'] ?>">
                                <button type="submit" class="btn btn-success">Approve</button>
                            </form>
                        <?php else: ?>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                                <input type="hidden" name="action" value="unapprove">
                                <input type="hidden" name="id" value="<?= $testimony['id'] ?>">
                                <button type="submit" class="btn btn-secondary">Unapprove</button>
                            </form>
                        <?php endif; ?>
                        
                        <?php if (!$testimony['is_featured']): ?>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                                <input type="hidden" name="action" value="feature">
                                <input type="hidden" name="id" value="<?= $testimony['id'] ?>">
                                <button type="submit" class="btn btn-secondary">Feature</button>
                            </form>
                        <?php endif; ?>
                        
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this testimony?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $testimony['id'] ?>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- View Modal -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <h2>Testimony Details</h2>
        <div id="testimonyContent"></div>
        <button class="btn btn-secondary" onclick="closeViewModal()">Close</button>
    </div>
</div>

<script>
function viewTestimony(testimony) {
    const content = `
        <p><strong>Author:</strong> ${testimony.author_name}</p>
        <p><strong>Church:</strong> ${testimony.church_name || '-'}</p>
        <p><strong>Submitted:</strong> ${testimony.created_at}</p>
        <p><strong>Status:</strong> ${testimony.is_approved ? 'Approved' : 'Pending'}</p>
        <p><strong>Featured:</strong> ${testimony.is_featured ? 'Yes' : 'No'}</p>
        <hr>
        <p><strong>Testimony:</strong></p>
        <p>${testimony.testimony}</p>
    `;
    document.getElementById('testimonyContent').innerHTML = content;
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
