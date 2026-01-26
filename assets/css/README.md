# CSS Files Organization

This folder contains modular CSS files for the AHFJCPI website.

## File Structure

```
assets/css/
├── base.css           # Base styles and reset
├── header.css         # Header and navigation
├── hero.css           # Hero section
├── leadership.css     # Leadership section
├── churches.css       # Churches section
├── events.css         # Events section
├── ministry.css       # Ministry section
├── testimonies.css    # Testimonies section
├── resources.css      # Resources section
├── about.css          # About section
├── giving.css         # Giving section
├── contact.css        # Contact section
├── gallery.css        # Gallery section
├── registration.css   # Registration section
├── footer.css         # Footer styles
└── responsive.css     # Responsive/media queries
```

## Loading Order

The CSS files are loaded in the HTML in this specific order:
1. **base.css** - Must be first (resets and global styles)
2. **Section-specific CSS** - In order of appearance on the page
3. **responsive.css** - Must be last (media queries override)

## Modifying Styles

### To change a specific section:
1. Find the corresponding CSS file
2. Edit only that file
3. Save and refresh the browser

### Adding new sections:
1. Create a new CSS file (e.g., `newsection.css`)
2. Add styles for that section
3. Link it in `index.html` before `responsive.css`

### Responsive changes:
- All responsive styles are in `responsive.css`
- Uses mobile-first approach
- Breakpoints: 1024px (tablet), 768px (mobile), 480px (small mobile)

## Benefits of Modular CSS

✅ **Easier to maintain** - Each section has its own file
✅ **Better organization** - Find styles quickly
✅ **Team collaboration** - Multiple people can work on different sections
✅ **Debugging** - Easier to identify which file has issues
✅ **Performance** - Can lazy-load sections if needed
✅ **Reusability** - Can reuse section styles in other projects

## File Sizes

Each file is small and focused:
- base.css (~500 bytes)
- Section files (~1-2 KB each)
- responsive.css (~4 KB)

Total CSS: ~15-20 KB (very lightweight!)
