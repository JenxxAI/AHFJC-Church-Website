<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Manage Ministry Posts';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('ministry.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    
    if ($action === 'add' || $action === 'edit') {
        $category = $_POST['category'];
        $title = sanitize($_POST['title']);
        $post_date = $_POST['post_date'];
        $description = sanitize($_POST['description']);
        $church_id = $_POST['church_id'] ? (int)$_POST['church_id'] : null;
        $is_active = isset($_POST['is_active']) ? 1 : 0;
        
        if ($action === 'add') {
            $stmt = $pdo->prepare("INSERT INTO ministry_posts (category, title, post_date, description, church_id, is_active) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$category, $title, $post_date, $description, $church_id, $is_active]);
            redirect('ministry.php', 'Ministry post added successfully');
        } else {
            $id = (int)$_POST['id'];
            $stmt = $pdo->prepare("UPDATE ministry_posts SET category=?, title=?, post_date=?, description=?, church_id=?, is_active=? WHERE id=?");
            $stmt->execute([$category, $title, $post_date, $description, $church_id, $is_active, $id]);
            redirect('ministry.php', 'Ministry post updated successfully');
        }
    } elseif ($action === 'delete') {
        $id = (int)$_POST['id'];
        $stmt = $pdo->prepare("DELETE FROM ministry_posts WHERE id=?");
        $stmt->execute([$id]);
        redirect('ministry.php', 'Ministry post deleted successfully');
    }
}

// Get all ministry posts
$stmt = $pdo->query("SELECT m.*, c.church_name FROM ministry_posts m LEFT JOIN churches c ON m.church_id = c.id ORDER BY m.post_date DESC");
$posts = $stmt->fetchAll();

// Get churches for dropdown
$stmt = $pdo->query("SELECT id, church_name FROM churches WHERE is_active = 1 ORDER BY church_name");
$churches = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="ministry-page">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1>Manage Ministry Posts</h1>
        <button class="btn btn-success" onclick="openModal('add')">+ Add Post</button>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Category</th>
                <th>Title</th>
                <th>Date</th>
                <th>Church</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($posts as $post): ?>
            <tr>
                <td><span class="badge badge-info"><?= ucfirst($post['category']) ?></span></td>
                <td><?= htmlspecialchars($post['title']) ?></td>
                <td><?= formatDate($post['post_date']) ?></td>
                <td><?= htmlspecialchars($post['church_name'] ?? '-') ?></td>
                <td><?= getStatusBadge($post['is_active']) ?></td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='editPost(<?= json_encode($post) ?>)'>Edit</button>
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this post?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $post['id'] ?>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="postModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle">Add Ministry Post</h2>
        <form method="POST">
            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="postId" value="">
            
            <div class="form-group">
                <label>Category *</label>
                <select name="category" id="category" required>
                    <option value="outreach">Outreach</option>
                    <option value="fellowship">Fellowship</option>
                    <option value="mission">Mission</option>
                    <option value="baptism">Baptism</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Title *</label>
                <input type="text" name="title" id="title" required>
            </div>
            
            <div class="form-group">
                <label>Date *</label>
                <input type="date" name="post_date" id="post_date" required>
            </div>
            
            <div class="form-group">
                <label>Church</label>
                <select name="church_id" id="church_id">
                    <option value="">- Select Church -</option>
                    <?php foreach ($churches as $church): ?>
                        <option value="<?= $church['id'] ?>"><?= htmlspecialchars($church['church_name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" id="description"></textarea>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" name="is_active" id="is_active" checked>
                    Active
                </label>
            </div>
            
            <div style="display: flex; gap: 1rem;">
                <button type="submit" class="btn btn-success">Save</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
function openModal(action) {
    document.getElementById('postModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Add Ministry Post';
    document.getElementById('formAction').value = 'add';
    document.querySelector('form').reset();
}

function closeModal() {
    document.getElementById('postModal').classList.remove('active');
}

function editPost(post) {
    document.getElementById('postModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Edit Ministry Post';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('postId').value = post.id;
    document.getElementById('category').value = post.category;
    document.getElementById('title').value = post.title;
    document.getElementById('post_date').value = post.post_date;
    document.getElementById('church_id').value = post.church_id || '';
    document.getElementById('description').value = post.description || '';
    document.getElementById('is_active').checked = post.is_active == 1;
}

document.getElementById('postModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});
</script>

<?php include '../includes/admin-footer.php'; ?>
