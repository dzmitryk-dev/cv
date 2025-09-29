# CV Template Usage Guide

This Pandoc template converts Markdown CV files into a styled HTML CV with a VS Code dark theme aesthetic.

## Required Template Variables

Add these to the YAML front-matter of your `cv.md` file:

- `title`: Page title (appears in browser tab)
- `name`: Your full name  
- `role`: Your professional role/title
- `location`: Your city and country
- `email`: Email address
- `phone`: Phone number
- `github`: GitHub profile URL (without https://)
- `linkedin`: LinkedIn profile URL (without https://)
- `date`: Last updated date
- `avatar`: Path to profile image (e.g., `avatar.webp`)

## Optional Variables

- `skills`: List of skills (see commented example in template)

## Sample YAML Front-Matter

```yaml
---
title: "Dzmitry Kalianchuk — CV"
name: "Dzmitry Kalianchuk"
role: "Lead Android Engineer"
location: "Kraków, Poland"
email: "koirn.on@gmail.com"
phone: "+48 123 456 789"
github: "github.com/dzmitryk-dev"
linkedin: "linkedin.com/in/dzmitryk-dev"
date: "2025-09-29"
avatar: "avatar.webp"
# Optional extras
# skills:
#   - "Kotlin"
#   - "Java"  
#   - "Android SDK"
#   - "Jetpack Compose"
---
```

## Usage Commands

### Generate HTML CV
```bash
pandoc cv.md --from=markdown-autolink_bare_uris --template=template/cv.html --standalone --output=dist/cv.html
```

### Preview in Browser
Open `dist/cv.html` in Chrome/Firefox for screen preview, or use Chrome's print preview for A4 PDF layout.

### Generate PDF (requires wkhtmltopdf or similar)
```bash
# Option 1: Using Chrome headless
google-chrome --headless --disable-gpu --print-to-pdf=dist/cv.pdf dist/cv.html

# Option 2: Using wkhtmltopdf  
wkhtmltopdf --page-size A4 --margin-top 12mm --margin-bottom 12mm --margin-left 12mm --margin-right 12mm dist/cv.html dist/cv.pdf
```

## Template Features

- **Responsive design**: Works on desktop and mobile
- **Print-optimized**: A4 format with proper margins and print-friendly colors
- **VS Code theme**: Dark theme for screen, clean professional look for print
- **Semantic HTML**: Uses proper HTML5 semantic elements
- **Line numbering**: Static line numbers (1-100) provide VS Code editor aesthetic
- **No JavaScript required**: Pure CSS and HTML solution for maximum compatibility

## Markdown Content Structure

Your `cv.md` content (after the YAML front-matter) can use standard Markdown:

```markdown
## Summary
Brief professional summary...

## Main Skills  
- Skill 1
- Skill 2

## Work Experience
### Job Title @ Company Name
*2020 - Present*

- Achievement or responsibility
- Another achievement

## Education
### Degree Name
*Institution Name, 2015 - 2019*
```

The template will automatically style headings, lists, and text with appropriate VS Code theme colors.

## File Structure

```
project/
├─ template/
│  ├─ cv.html          # Pandoc template
│  └─ style.css        # Styles (screen + print)
├─ cv.md               # Your CV content + YAML
├─ dist/               # Generated HTML/PDF output
└─ assets/             # Images (optional)
   └─ avatar.webp
```