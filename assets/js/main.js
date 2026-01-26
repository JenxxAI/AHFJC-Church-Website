// Main JavaScript file for AHFJCPI website
// API Configuration
const API_BASE_URL = 'api/get-content.php';

// Utility function to fetch data from API
async function fetchAPI(type, params = {}) {
    try {
        const queryParams = new URLSearchParams({ type, ...params });
        const response = await fetch(`${API_BASE_URL}?${queryParams}`);
        const data = await response.json();
        
        if (data.success) {
            return data.data;
        } else {
            console.error('API Error:', data.error);
            return null;
        }
    } catch (error) {
        console.error('Fetch Error:', error);
        return null;
    }
}

// Utility function to format date
function formatDate(dateString) {
    const date = new Date(dateString);
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return `${months[date.getMonth()]} ${date.getDate()}, ${date.getFullYear()}`;
}

// Load Events
async function loadEvents() {
    const events = await fetchAPI('events', { upcoming: 'true' });
    if (!events || events.length === 0) return;
    
    const eventsGrid = document.querySelector('.events-grid');
    if (!eventsGrid) return;
    
    eventsGrid.innerHTML = events.slice(0, 3).map(event => `
        <div class="event-card">
            <div class="event-date">${formatDate(event.event_date)}</div>
            <h3>${event.event_title}</h3>
            <p>${event.description}</p>
            <p class="event-location">📍 ${event.church_name || event.location}</p>
        </div>
    `).join('');
}

// Load Leadership
async function loadLeadership() {
    const leaders = await fetchAPI('leadership');
    if (!leaders || leaders.length === 0) return;
    
    const leadersGrid = document.querySelector('.leaders-grid');
    if (!leadersGrid) return;
    
    leadersGrid.innerHTML = leaders.map(leader => `
        <div class="leader-card">
            <div class="position">${leader.position}</div>
            <h3>${leader.full_name}</h3>
            <p>${leader.description || 'Church Leader'}</p>
        </div>
    `).join('');
}

// Load Churches
async function loadChurches() {
    const churches = await fetchAPI('churches');
    if (!churches || churches.length === 0) return;
    
    const churchesGrid = document.querySelector('.churches-grid');
    if (!churchesGrid) return;
    
    const churchIcon = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
        <path d="M12 2L3 9v11a2 2 0 002 2h14a2 2 0 002-2V9l-9-7z"/>
        <path d="M12 2v20"/>
        <path d="M9 12h6"/>
    </svg>`;
    
    churchesGrid.innerHTML = churches.map(church => `
        <div class="church-card">
            <div class="church-image">${churchIcon}</div>
            <div class="church-content">
                <h3>${church.church_name}</h3>
                <p class="pastor-label">Host Pastor</p>
                <p>${church.pastor_name}</p>
                ${church.address ? `<p class="church-address">${church.address}</p>` : ''}
                ${church.phone ? `<p class="church-phone">📞 ${church.phone}</p>` : ''}
            </div>
        </div>
    `).join('');
}

// Load Ministry Posts
async function loadMinistry() {
    const ministryPosts = await fetchAPI('ministry');
    if (!ministryPosts || ministryPosts.length === 0) return;
    
    const ministryGrid = document.querySelector('.ministry-grid');
    if (!ministryGrid) return;
    
    const categoryIcons = {
        'Outreach': `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 00-3-3.87"/>
            <path d="M16 3.13a4 4 0 010 7.75"/>
        </svg>`,
        'Fellowship': `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
            <circle cx="12" cy="12" r="10"/>
            <path d="M8 14s1.5 2 4 2 4-2 4-2"/>
            <line x1="9" y1="9" x2="9.01" y2="9"/>
            <line x1="15" y1="9" x2="15.01" y2="9"/>
        </svg>`,
        'Mission': `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M12 2L2 7l10 5 10-5-10-5z"/>
            <path d="M2 17l10 5 10-5"/>
            <path d="M2 12l10 5 10-5"/>
        </svg>`,
        'Baptism': `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M12 2.69l5.66 5.66a8 8 0 11-11.31 0z"/>
            <circle cx="12" cy="12" r="3"/>
        </svg>`
    };
    
    ministryGrid.innerHTML = ministryPosts.slice(0, 6).map(post => `
        <div class="ministry-card">
            <div class="ministry-image">${categoryIcons[post.category] || categoryIcons['Fellowship']}</div>
            <div class="ministry-content">
                <div class="ministry-category">${post.category}</div>
                <h3>${post.title}</h3>
                <div class="date">${formatDate(post.post_date)}</div>
                <p>${post.description || ''}</p>
            </div>
        </div>
    `).join('');
}

// Load Testimonies
async function loadTestimonies() {
    const testimonies = await fetchAPI('testimonies', { featured: 'true' });
    if (!testimonies || testimonies.length === 0) return;
    
    const testimoniesGrid = document.querySelector('.testimonies-grid');
    if (!testimoniesGrid) return;
    
    testimoniesGrid.innerHTML = testimonies.slice(0, 3).map(testimony => `
        <div class="testimony-card">
            <div class="testimony-content">
                <p>${testimony.testimony}</p>
            </div>
            <div class="testimony-author">
                <strong>${testimony.author_name}</strong>
                <div class="testimony-church">${testimony.church_name || 'AHFJCPI Member'}</div>
            </div>
        </div>
    `).join('');
}

// Load Resources
async function loadResources() {
    const resources = await fetchAPI('resources');
    if (!resources || resources.length === 0) return;
    
    const resourcesGrid = document.querySelector('.resources-grid');
    if (!resourcesGrid) return;
    
    resourcesGrid.innerHTML = resources.slice(0, 6).map(resource => `
        <div class="resource-card">
            <div class="resource-type">${resource.resource_type}</div>
            <h3>${resource.title}</h3>
            <p>${resource.description || ''}</p>
            ${resource.file_url ? `<a href="${resource.file_url}" class="download-btn" target="_blank">Download PDF</a>` : ''}
        </div>
    `).join('');
}

document.addEventListener('DOMContentLoaded', function() {
    // Load dynamic content from database
    loadEvents();
    loadLeadership();
    loadChurches();
    loadMinistry();
    loadTestimonies();
    loadResources();

    // Mobile menu toggle
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('nav ul');
    const navLinks = document.querySelectorAll('nav a');

    // Toggle mobile menu
    if (menuToggle) {
        menuToggle.addEventListener('click', function(e) {
            e.stopPropagation();
            this.classList.toggle('active');
            navMenu.classList.toggle('active');
        });

        // Close menu when clicking on a link
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                menuToggle.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });

        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!menuToggle.contains(e.target) && !navMenu.contains(e.target)) {
                menuToggle.classList.remove('active');
                navMenu.classList.remove('active');
            }
        });
    }

    // Smooth scrolling for navigation links
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Prayer Form submission handler
    const prayerForm = document.querySelector('.prayer-form form');
    if (prayerForm) {
        prayerForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = {
                name: this.querySelector('#name').value,
                email: this.querySelector('#email').value,
                phone: this.querySelector('#phone')?.value || '',
                request: this.querySelector('#prayer').value
            };
            
            try {
                const response = await fetch(`${API_BASE_URL}?type=submit_prayer`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(formData)
                });
                
                const result = await response.json();
                
                if (result.success) {
                    alert('Thank you for your prayer request. We will be praying for you!');
                    this.reset();
                } else {
                    alert(result.error || 'Failed to submit prayer request. Please try again.');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred. Please try again later.');
            }
        });
    }
});
