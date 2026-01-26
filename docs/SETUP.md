# AHFJCPI Website - Project Setup Guide

## Project Information

- **Project Name**: AHFJCPI Church Website
- **Repository**: https://github.com/JenxxAI/AHFJC-Church-Website
- **Technology Stack**: HTML5, CSS3, JavaScript (Vanilla)
- **Type**: Static Website

## Folder Structure

```
AHFJC-Church-Website/
│
├── index.html                 # Main entry point
│
├── assets/                    # Static assets
│   ├── css/
│   │   └── style.css         # Main stylesheet
│   ├── js/
│   │   └── main.js           # Main JavaScript file
│   ├── images/               # Image assets
│   │   └── README.md
│   └── fonts/                # Custom fonts (if needed)
│
├── docs/                     # Documentation & resources
│   └── README.md
│
├── .gitignore                # Git ignore rules
├── LICENSE                   # License file
└── README.md                 # Project documentation
```

## Development Setup

### Prerequisites

- A modern web browser (Chrome, Firefox, Safari, Edge)
- A code editor (VS Code, Sublime Text, etc.)
- Optional: Local web server for development

### Running Locally

**Option 1: Direct File Access**
Simply open `index.html` in your web browser.

**Option 2: Python HTTP Server**
```bash
cd AHFJC-Church-Website
python -m http.server 8000
```
Then visit: http://localhost:8000

**Option 3: Node.js HTTP Server**
```bash
npx http-server
```

**Option 4: VS Code Live Server**
Install the "Live Server" extension and right-click `index.html` → "Open with Live Server"

## File Descriptions

### HTML Files
- **index.html**: Main website page containing all sections

### CSS Files
- **assets/css/**: Modular CSS files organized by section
  - base.css - Reset and global styles
  - header.css, hero.css, leadership.css, etc. - Section-specific styles
  - responsive.css - All responsive/media queries (MUST be loaded last)
  
Benefits of modular CSS:
- Easy to find and edit specific sections
- Better organization and maintainability
- Team members can work on different files
- Faster debugging and development

### JavaScript Files
- **assets/js/main.js**: Interactive functionality
  - Smooth scrolling navigation
  - Form handling
  - Dynamic features

### Asset Directories
- **assets/images/**: Store all images here
  - Church photos
  - Event images
  - Leadership photos
  - Gallery images

- **assets/fonts/**: Custom fonts (if any)

- **docs/**: PDF resources and documentation
  - Study guides
  - Sermon notes
  - Teaching materials

## Customization Guide

### Adding New Sections

1. Add HTML section in `index.html`
2. Add corresponding styles in `assets/css/style.css`
3. Add navigation link in the nav menu
4. Add JavaScript if needed in `assets/js/main.js`

### Updating Content

- **Events**: Edit the events section in `index.html`
- **Churches**: Update church cards in the churches section
- **Testimonies**: Add new testimony cards
- **Resources**: Add links to PDF files in the docs folder

### Styling Changes

CSS is organized into modular files in `assets/css/`:

**Base Styles:**
- `base.css` - Global resets and container styles

**Section Styles:**
- `header.css` - Header and navigation
- `hero.css` - Hero section
- `leadership.css` - Leadership section
- `churches.css` - Churches section
- `events.css` - Events section
- `ministry.css` - Ministry section
- `testimonies.css` - Testimonies section
- `resources.css` - Resources section
- `about.css` - About section
- `giving.css` - Giving section
- `contact.css` - Contact section
- `gallery.css` - Gallery section
- `registration.css` - Registration section
- `footer.css` - Footer styles

**Responsive:**
- `responsive.css` - All media queries (loaded last)

The website uses:
- CSS Grid for layouts
- Flexbox for alignment
- Mobile-first responsive design
- Breakpoints: 1024px (tablet), 768px (mobile), 480px (small mobile)

## Deployment Options

### GitHub Pages
1. Go to repository Settings → Pages
2. Select branch (main)
3. Select folder (root)
4. Save
5. Website will be live at: https://jenxxai.github.io/AHFJC-Church-Website/

### Netlify
1. Connect repository to Netlify
2. Set build command: (none needed for static site)
3. Set publish directory: /
4. Deploy

### Vercel
1. Import repository to Vercel
2. Auto-deployment on push

### Traditional Web Hosting
1. Upload all files via FTP
2. Ensure index.html is in the root directory
3. Preserve folder structure

## Maintenance

### Regular Updates
- Update event dates and information
- Add new testimonies
- Update ministry activities
- Refresh gallery photos
- Keep contact information current

### Performance
- Optimize images before uploading
- Keep CSS and JS files minimal
- Use browser caching

### SEO Considerations
- Update meta tags as needed
- Add alt text to all images
- Keep content fresh and relevant

## Support

For technical issues or questions:
- Check the README.md file
- Review documentation in /docs
- Contact your web administrator

---

**Last Updated**: January 26, 2026
