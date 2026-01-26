<?php
require_once '../config/database.php';
require_once '../includes/security.php';
require_once '../includes/functions.php';

requireLogin();
$page_title = 'Manage Events';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verifyCSRFToken($_POST['csrf_token'] ?? '')) {
        redirect('events.php', 'Invalid request', 'error');
    }
    
    $action = $_POST['action'] ?? '';
    
    if ($action === 'add' || $action === 'edit') {
        $event_title = sanitize($_POST['event_title']);
        $event_date = $_POST['event_date'];
        $event_time = $_POST['event_time'];
        $location = sanitize($_POST['location']);
        $church_id = $_POST['church_id'] ? (int)$_POST['church_id'] : null;
        $description = sanitize($_POST['description']);
        $is_featured = isset($_POST['is_featured']) ? 1 : 0;
        $is_active = isset($_POST['is_active']) ? 1 : 0;
        
        if ($action === 'add') {
            $stmt = $pdo->prepare("INSERT INTO events (event_title, event_date, event_time, location, church_id, description, is_featured, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$event_title, $event_date, $event_time, $location, $church_id, $description, $is_featured, $is_active]);
            redirect('events.php', 'Event added successfully');
        } else {
            $id = (int)$_POST['id'];
            $stmt = $pdo->prepare("UPDATE events SET event_title=?, event_date=?, event_time=?, location=?, church_id=?, description=?, is_featured=?, is_active=? WHERE id=?");
            $stmt->execute([$event_title, $event_date, $event_time, $location, $church_id, $description, $is_featured, $is_active, $id]);
            redirect('events.php', 'Event updated successfully');
        }
    } elseif ($action === 'delete') {
        $id = (int)$_POST['id'];
        $stmt = $pdo->prepare("DELETE FROM events WHERE id=?");
        $stmt->execute([$id]);
        redirect('events.php', 'Event deleted successfully');
    }
}

// Get all events
$stmt = $pdo->query("SELECT e.*, c.church_name FROM events e LEFT JOIN churches c ON e.church_id = c.id ORDER BY e.event_date DESC");
$events = $stmt->fetchAll();

// Get churches for dropdown
$stmt = $pdo->query("SELECT id, church_name FROM churches WHERE is_active = 1 ORDER BY church_name");
$churches = $stmt->fetchAll();

$csrf_token = generateCSRFToken();
include '../includes/admin-header.php';
?>

<div class="events-page">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1>Manage Events</h1>
        <button class="btn btn-success" onclick="openModal('add')">+ Add Event</button>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Event Title</th>
                <th>Date & Time</th>
                <th>Location</th>
                <th>Church</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($events as $event): ?>
            <tr>
                <td>
                    <?= htmlspecialchars($event['event_title']) ?>
                    <?php if ($event['is_featured']): ?>
                        <span class="badge badge-warning">Featured</span>
                    <?php endif; ?>
                </td>
                <td>
                    <?= formatDate($event['event_date']) ?><br>
                    <?= $event['event_time'] ? date('g:i A', strtotime($event['event_time'])) : '' ?>
                </td>
                <td><?= htmlspecialchars($event['location']) ?></td>
                <td><?= htmlspecialchars($event['church_name'] ?? '-') ?></td>
                <td><?= getStatusBadge($event['is_active']) ?></td>
                <td>
                    <div class="actions">
                        <button class="btn btn-secondary" onclick='editEvent(<?= json_encode($event) ?>)'>Edit</button>
                        <form method="POST" style="display:inline;" onsubmit="return confirm('Delete this event?')">
                            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= $event['id'] ?>">
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
<div id="eventModal" class="modal">
    <div class="modal-content">
        <h2 id="modalTitle">Add Event</h2>
        <form method="POST">
            <input type="hidden" name="csrf_token" value="<?= $csrf_token ?>">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="eventId" value="">
            
            <div class="form-group">
                <label>Event Title *</label>
                <input type="text" name="event_title" id="event_title" required>
            </div>
            
            <div class="form-group">
                <label>Event Date *</label>
                <input type="date" name="event_date" id="event_date" required>
            </div>
            
            <div class="form-group">
                <label>Event Time</label>
                <input type="time" name="event_time" id="event_time">
            </div>
            
            <div class="form-group">
                <label>Location *</label>
                <input type="text" name="location" id="location" required>
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
                    <input type="checkbox" name="is_featured" id="is_featured">
                    Featured Event
                </label>
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
    document.getElementById('eventModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Add Event';
    document.getElementById('formAction').value = 'add';
    document.querySelector('form').reset();
}

function closeModal() {
    document.getElementById('eventModal').classList.remove('active');
}

function editEvent(event) {
    document.getElementById('eventModal').classList.add('active');
    document.getElementById('modalTitle').textContent = 'Edit Event';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('eventId').value = event.id;
    document.getElementById('event_title').value = event.event_title;
    document.getElementById('event_date').value = event.event_date;
    document.getElementById('event_time').value = event.event_time || '';
    document.getElementById('location').value = event.location;
    document.getElementById('church_id').value = event.church_id || '';
    document.getElementById('description').value = event.description || '';
    document.getElementById('is_featured').checked = event.is_featured == 1;
    document.getElementById('is_active').checked = event.is_active == 1;
}

document.getElementById('eventModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});
</script>

<?php include '../includes/admin-footer.php'; ?>
