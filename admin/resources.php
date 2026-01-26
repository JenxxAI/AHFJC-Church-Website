<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Manage Resources';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('resources.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    
    if ($action === 'add' || $action === 'edit') {
        $resource_type = sanitize($_POST['resource_type']);
        $title = sanitize($_POST['title']);
        $description = sanitize($_POST['description']);
        $file_url = sanitize($_POST['file_url']);
        $is_active = isset($_POST['is_active']) ? 1 : 0;
        
        if ($action === 'add') {
            $stmt = $pdo->prepare("INSERT INTO resources (resource_type, title, description, file_url, is_active) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$resource_type, $title, $description, $file_url, $is_active]);
            redirect('resources.php', 'Resource added successfully');
        } else {
            $id = (int)$_POST['id'];
            $stmt = $pdo->prepare("UPDATE resources SET resource_type=?, title=?, description=?, file_url=?, is_active=? WHERE id=?");
            $stmt->execute([$resource_type, $title, $description, $file_url, $is_active, $id]);
            redirect('resources.php', 'Resource updated successfully');
        }
    } elseif ($action === 'delete') {
        $id = (int)$_POST['id'];
        $stmt = $pdo->prepare("DELETE FROM resources WHERE id=?");
        $stmt->execute([$id]);
        redirect('resources.php', 'Resource deleted successfully');
    }
}

// Get all resources
$stmt = $pdo->query("SELECT * FROM resources ORDER BY created_at DESC");
$resources = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="resources-page">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1>Manage Resources</h1>
        <button class="btn btn-success" onclick="openModal('add')">+ Add Resource</button>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Type</th>
                <th>Title</th>
                <th>File URL</th>
                <th>Downloads</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($resources as $resource): ?>
            <tr>
                <td><span class="badge badge-info"><?= htmlspecialchars($resource['resource_type']) ?></span></td>
                <td><?= htmlspecialchars($resource['title']) ?></td>
                <td><a href="<?= htmlspecialchars($resource['file_url']) ?>" target="_blank">View File</a></td>
                <td><?= $resource['download_count'] ?></td>
                <td><?= getStatusBadge($resource['is_active']) ?></td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='editResource(<?= json_encode($resource) ?>)'>Edit</button>
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this resource?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $resource['id'] ?>">
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
<div id="resourceModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle">Add Resource</h2>
        <form method="POST">
            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="resourceId" value="">
            
            <div class="form-group">
                <label>Resource Type *</label>
                <input type="text" name="resource_type" id="resource_type" placeholder="e.g., PDF, Video, Document" required>
            </div>
            
            <div class="form-group">
                <label>Title *</label>
                <input type="text" name="title" id="title" required>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" id="description"></textarea>
            </div>
            
            <div class="form-group">
                <label>File URL *</label>
                <input type="url" name="file_url" id="file_url" placeholder="https://..." required>
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
    document.getElementById('resourceModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Add Resource';
    document.getElementById('formAction').value = 'add';
    document.querySelector('form').reset();
}

function closeModal() {
    document.getElementById('resourceModal').classList.remove('active');
}

function editResource(resource) {
    document.getElementById('resourceModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Edit Resource';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('resourceId').value = resource.id;
    document.getElementById('resource_type').value = resource.resource_type;
    document.getElementById('title').value = resource.title;
    document.getElementById('description').value = resource.description || '';
    document.getElementById('file_url').value = resource.file_url;
    document.getElementById('is_active').checked = resource.is_active == 1;
}

document.getElementById('resourceModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});
</script>

<?php include '../includes/admin-footer.php'; ?>
