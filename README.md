# CV Template - Pandoc HTML Template

A modern HTML CV template with VS Code dark theme styling that converts Markdown to professional-looking HTML CVs.

## Quick Start

1. Install Pandoc:
   ```bash
   # macOS
   brew install pandoc
   
   # Ubuntu/Debian
   sudo apt install pandoc
   
   # Windows (with Chocolatey)
   choco install pandoc
   ```

2. Generate your CV:
   ```bash
   pandoc cv.md --from=markdown-autolink_bare_uris --template=template/cv.html --standalone --output=dist/cv.html
   ```

3. Open `dist/cv.html` in Chrome/Firefox to preview

4. Use Chrome's Print Preview (Ctrl+P) to see A4 PDF layout

## Features

- **VS Code themed design**: Dark theme for screen, professional for print
- **Print optimized**: A4 format with proper margins
- **Responsive layout**: Works on desktop and mobile  
- **Line numbering**: Static line numbers (1-100) provide VS Code editor aesthetic
- **Semantic HTML**: Proper HTML5 structure for accessibility

## Template Structure

```
├─ template/
│  ├─ cv.html          # Pandoc template file
│  └─ style.css        # Styles (screen + print media queries)
├─ cv.md               # Your CV content with YAML front-matter
├─ dist/               # Generated output
├─ TEMPLATE_NOTES.md   # Detailed usage guide
└─ README.md           # This file
```

See `TEMPLATE_NOTES.md` for detailed usage instructions and YAML configuration options. 
