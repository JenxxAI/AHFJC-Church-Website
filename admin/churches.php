<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Manage Churches';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('churches.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    
    if ($action === 'add' || $action === 'edit') {
        $church_name = sanitize($_POST['church_name']);
        $pastor_name = sanitize($_POST['pastor_name']);
        $location = sanitize($_POST['location']);
        $phone = sanitize($_POST['phone']);
        $email = sanitize($_POST['email']);
        $address = sanitize($_POST['address']);
        $display_order = (int)$_POST['display_order'];
        $is_active = isset($_POST['is_active']) ? 1 : 0;
        
        if ($action === 'add') {
            $stmt = $pdo->prepare("INSERT INTO churches (church_name, pastor_name, location, phone, email, address, display_order, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$church_name, $pastor_name, $location, $phone, $email, $address, $display_order, $is_active]);
            redirect('churches.php', 'Church added successfully');
        } else {
            $id = (int)$_POST['id'];
            $stmt = $pdo->prepare("UPDATE churches SET church_name=?, pastor_name=?, location=?, phone=?, email=?, address=?, display_order=?, is_active=? WHERE id=?");
            $stmt->execute([$church_name, $pastor_name, $location, $phone, $email, $address, $display_order, $is_active, $id]);
            redirect('churches.php', 'Church updated successfully');
        }
    } elseif ($action === 'delete') {
        $id = (int)$_POST['id'];
        $stmt = $pdo->prepare("DELETE FROM churches WHERE id=?");
        $stmt->execute([$id]);
        redirect('churches.php', 'Church deleted successfully');
    }
}

// Get all churches
$stmt = $pdo->query("SELECT * FROM churches ORDER BY display_order, church_name");
$churches = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="churches-page">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1>Manage Churches</h1>
        <button class="btn btn-success" onclick="openModal('add')">+ Add Church</button>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Order</th>
                <th>Church Name</th>
                <th>Pastor</th>
                <th>Location</th>
                <th>Contact</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($churches as $church): ?>
            <tr>
                <td><?= $church['display_order'] ?></td>
                <td><?= htmlspecialchars($church['church_name']) ?></td>
                <td><?= htmlspecialchars($church['pastor_name']) ?></td>
                <td><?= htmlspecialchars($church['location']) ?></td>
                <td>
                    <?php if ($church['phone']): ?>
                        <?= htmlspecialchars($church['phone']) ?><br>
                    <?php endif; ?>
                    <?= htmlspecialchars($church['email']) ?>
                </td>
                <td><?= getStatusBadge($church['is_active']) ?></td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='editChurch(<?= json_encode($church) ?>)'>Edit</button>
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this church?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $church['id'] ?>">
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
<div id="churchModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle">Add Church</h2>
        <form method="POST">
            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="churchId" value="">
            
            <div class="form-group">
                <label>Church Name *</label>
                <input type="text" name="church_name" id="church_name" required>
            </div>
            
            <div class="form-group">
                <label>Pastor Name *</label>
                <input type="text" name="pastor_name" id="pastor_name" required>
            </div>
            
            <div class="form-group">
                <label>Location *</label>
                <input type="text" name="location" id="location" required>
            </div>
            
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" id="phone">
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email">
            </div>
            
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" id="address"></textarea>
            </div>
            
            <div class="form-group">
                <label>Display Order</label>
                <input type="number" name="display_order" id="display_order" value="0">
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
    document.getElementById('churchModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Add Church';
    document.getElementById('formAction').value = 'add';
    document.querySelector('form').reset();
}

function closeModal() {
    document.getElementById('churchModal').classList.remove('active');
}

function editChurch(church) {
    document.getElementById('churchModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Edit Church';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('churchId').value = church.id;
    document.getElementById('church_name').value = church.church_name;
    document.getElementById('pastor_name').value = church.pastor_name;
    document.getElementById('location').value = church.location;
    document.getElementById('phone').value = church.phone || '';
    document.getElementById('email').value = church.email || '';
    document.getElementById('address').value = church.address || '';
    document.getElementById('display_order').value = church.display_order;
    document.getElementById('is_active').checked = church.is_active == 1;
}

// Close modal on outside click
document.getElementById('churchModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});
</script>

<?php include '../includes/admin-footer.php'; ?>
