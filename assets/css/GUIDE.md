# CSS Organization Guide

## ✅ CSS is now properly separated!

### 📊 Total Statistics
- **16 modular CSS files**
- **Total size: 72KB** (lightweight and optimized)
- **Organized by section** for easy maintenance

## 📁 File Organization

### 1. Base Styles (Load First)
```
base.css (580 bytes)
├── Reset styles
├── Global font settings
├── Container layout
└── Section title styles
```

### 2. Header & Navigation
```
header.css (1.1KB)
├── Header styles
├── Logo/acronym
└── Navigation menu
```

### 3. Page Sections (In Page Order)
```
hero.css (431 bytes)        → Hero/welcome section
leadership.css (643 bytes)  → Leadership team
churches.css (1.0KB)        → Church locations
events.css (896 bytes)      → Events calendar
ministry.css (1.2KB)        → Ministry activities
testimonies.css (656 bytes) → Testimonials
resources.css (1.1KB)       → Downloadable resources
about.css (795 bytes)       → About/mission/vision
giving.css (726 bytes)      → Donation information
contact.css (2.0KB)         → Contact forms
gallery.css (531 bytes)     → Photo gallery
registration.css (1.8KB)    → Event registration
```

### 4. Footer
```
footer.css (245 bytes)
└── Footer styles
```

### 5. Responsive (Load Last)
```
responsive.css (4.0KB)
├── Tablet: @media (max-width: 1024px)
├── Mobile: @media (max-width: 768px)
└── Small Mobile: @media (max-width: 480px)
```

## 🎯 Loading Order in HTML

```html
<!-- 1. Base styles FIRST -->
<link rel="stylesheet" href="assets/css/base.css">

<!-- 2. Header -->
<link rel="stylesheet" href="assets/css/header.css">

<!-- 3. Page sections in order -->
<link rel="stylesheet" href="assets/css/hero.css">
<link rel="stylesheet" href="assets/css/leadership.css">
<link rel="stylesheet" href="assets/css/churches.css">
<link rel="stylesheet" href="assets/css/events.css">
<link rel="stylesheet" href="assets/css/ministry.css">
<link rel="stylesheet" href="assets/css/testimonies.css">
<link rel="stylesheet" href="assets/css/resources.css">
<link rel="stylesheet" href="assets/css/about.css">
<link rel="stylesheet" href="assets/css/giving.css">
<link rel="stylesheet" href="assets/css/contact.css">
<link rel="stylesheet" href="assets/css/gallery.css">
<link rel="stylesheet" href="assets/css/registration.css">

<!-- 4. Footer -->
<link rel="stylesheet" href="assets/css/footer.css">

<!-- 5. Responsive LAST (overrides other styles) -->
<link rel="stylesheet" href="assets/css/responsive.css">
```

## 🔧 How to Edit Styles

### Example 1: Change header background color
Edit: `assets/css/header.css`
```css
header {
    background: #1a1a1a;  /* Change from #000000 to #1a1a1a */
}
```

### Example 2: Adjust church card spacing
Edit: `assets/css/churches.css`
```css
.churches-grid {
    gap: 3rem;  /* Increase from 2rem to 3rem */
}
```

### Example 3: Modify mobile navigation
Edit: `assets/css/responsive.css`
```css
@media (max-width: 768px) {
    nav ul {
        gap: 1rem;  /* Change spacing */
    }
}
```

## ✨ Benefits of This Organization

### ✅ Easy Maintenance
- Find styles quickly - each section has its own file
- No more searching through 1000+ lines of CSS
- Clear separation of concerns

### ✅ Team Collaboration
- Multiple developers can work on different sections
- Reduce merge conflicts in version control
- Clear ownership of code sections

### ✅ Performance
- Browser can cache individual files
- Load only needed sections (future optimization)
- Faster development and debugging

### ✅ Scalability
- Add new sections easily (create new CSS file)
- Remove sections without affecting others
- Reuse section styles in other projects

### ✅ Better Debugging
- Inspect element shows which CSS file
- Quickly locate the issue
- Test changes to one section at a time

## 🚨 Important Rules

1. **ALWAYS load base.css first**
2. **ALWAYS load responsive.css last**
3. **Never delete responsive.css** - it contains all media queries
4. **Keep files focused** - one section per file
5. **Document changes** in comments

## 📱 Responsive Design

All responsive styles are in `responsive.css`:

- **Desktop**: Default styles (no media query)
- **Tablet**: 1024px and below
- **Mobile**: 768px and below  
- **Small Mobile**: 480px and below

## 🎨 Quick Reference

| File | Purpose | Size |
|------|---------|------|
| base.css | Global styles | 580B |
| header.css | Header & nav | 1.1KB |
| responsive.css | All breakpoints | 4.0KB |
| contact.css | Contact forms | 2.0KB |
| registration.css | Registration | 1.8KB |
| ministry.css | Ministry cards | 1.2KB |

---

**Last Updated**: January 26, 2026
