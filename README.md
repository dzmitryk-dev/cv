# CV Generator

A modern, modular CV generation system that creates professional HTML and PDF CVs from structured Markdown and YAML content. Features a VS Code dark theme aesthetic with print-optimized styling.

## Project Structure

```
cv/
├── build_html.sh          # Script to generate HTML CV from content files
├── Makefile               # Build targets for HTML, PDF, Docker image, and cleanup
├── README.md              # This documentation
├── content/               # CV content files
│   ├── meta.yml           # Basic metadata (title, avatar path)
│   ├── contacts.yml       # Personal information (name, role, location, contacts)
│   ├── skills.yml         # Skills organized in categories
│   ├── summary.md         # Professional summary
│   ├── achievements.md    # Key achievements and highlights
│   ├── responsibilities.md # Professional responsibilities and duties
│   ├── strengths.md       # Core professional strengths and capabilities
│   ├── experience.md      # Work experience history
│   ├── education.md       # Education background
│   ├── languages.md       # Language proficiencies
│   └── avatar.webp        # Profile picture
├── docker/                # Docker setup for containerized generation
│   ├── Dockerfile         # Docker image definition
│   └── scripts/
│       ├── build.sh       # Build Docker image
│       └── generate.sh    # Generate CV using Docker
├── pdf/                   # PDF generation tools
│   └── generate-pdf.js    # Node.js script using Puppeteer for PDF creation
└── template/              # HTML template and styling
    ├── cv.html            # Pandoc HTML template
    └── style.css          # CSS styles (screen + print media queries)
```

## CV Content Structure

The CV content is organized into modular files for easy maintenance and updates:

### Core Metadata Files (YAML)

- **`meta.yml`**: Contains basic page metadata
  - `title`: Browser tab title
  - `avatar`: Path to profile image
- **`contacts.yml`**: Personal and contact information
  - `name`: Full name
  - `role`: Professional title
  - `location`: City and country
  - `email`, `phone`: Contact details
  - `github`, `linkedin`: Professional profiles (without https://)
- **`skills.yml`**: Technical and professional skills organized in categories
  - Structured as `skill_categories` with `name` and `items` arrays

### Content Sections (Markdown)

- **`summary.md`**: Brief professional summary (plain text)
- **`achievements.md`**: Key accomplishments and highlights (Markdown formatted)
- **`responsibilities.md`**: Key professional responsibilities and duties (Markdown formatted)
- **`strengths.md`**: Core professional strengths and capabilities (Markdown formatted)
- **`experience.md`**: Work experience with job titles, companies, dates, and descriptions (Markdown formatted)
- **`education.md`**: Educational background and qualifications (Markdown formatted)
- **`languages.md`**: Language proficiencies and levels (Markdown formatted)

### Assets

- **`avatar.webp`**: Profile picture (WebP format recommended for smaller file size)

## How to Generate CV

### Prerequisites

#### For HTML Generation

- **Pandoc**: Required for converting Markdown to HTML

  ```bash
  # macOS
  brew install pandoc

  # Ubuntu/Debian
  sudo apt install pandoc

  # Windows (with Chocolatey)
  choco install pandoc
  ```

#### For PDF Generation (Local)

- **Node.js** (v14+): Required for PDF generation
- **Puppeteer**: Install dependencies

  ```bash
  npm install puppeteer
  ```

#### For PDF Generation (Docker - Recommended)

- **Docker**: For containerized PDF generation (includes all dependencies)

### Generate HTML CV

#### Option 1: Direct script execution

```bash
./build_html.sh
```

- Generates `dist/cv.html` with current date
- Optional: Add `--open` flag to automatically open in browser

#### Option 2: Using Makefile

```bash
make html
```

### Generate PDF CV

#### Option 1: Using Docker (Recommended)

```bash
# Build Docker image (one-time setup)
make image

# Generate both HTML and PDF
make pdf
```

#### Option 2: Local generation

```bash
# First generate HTML
./build_html.sh

# Then generate PDF
node pdf/generate-pdf.js
```

### Preview and Print

- **Web preview**: Open `dist/cv.html` in any modern browser
- **Print preview**: Use browser's print function (Ctrl+P/Cmd+P) for A4 PDF layout
- **Direct PDF**: Generated files are saved in `dist/` directory

## GitHub Actions Automation

This repository includes automated CV generation and release publishing using GitHub Actions.

### Creating Releases

**Method 1: Git Tags (Recommended)**
```bash
git tag v1.0
git push origin v1.0
```

**Method 2: Manual Trigger**
1. Go to **Actions** tab in your repository
2. Select "Generate CV and Create Release"
3. Click "Run workflow"

### What You Get

- **Automatic PDF generation** using your Docker setup
- **GitHub release** with downloadable `dzmitry_kalianchuk_cv.pdf`
- **Direct download link**: `https://github.com/USER/REPO/releases/latest/download/dzmitry_kalianchuk_cv.pdf`

### Testing

- **Pull requests** automatically test CV generation
- **All pushes** to main/master trigger build validation
- **Build artifacts** available for download from Actions tab## Maintenance Guide

### Updating Content

1. **Personal Information**: Edit `content/contacts.yml`
2. **Skills**: Modify `content/skills.yml` (add/remove categories or items)
3. **Professional Summary**: Update `content/summary.md`
4. **Achievements**: Update `content/achievements.md`
5. **Responsibilities**: Edit `content/responsibilities.md`
6. **Strengths**: Modify `content/strengths.md`
7. **Experience**: Edit `content/experience.md` with new positions or updates
8. **Education**: Modify `content/education.md`
9. **Languages**: Edit `content/languages.md`
10. **Profile Picture**: Replace `content/avatar.webp`

### File Organization Best Practices

- Keep content files focused on their specific sections
- Use Markdown formatting for rich text in experience, education, and achievements
- Maintain consistent date formats (e.g., "2020 - Present" or "2018 - 2022")
- Update the generation date automatically via build scripts

### Build System

- **HTML Generation**: Uses Pandoc with custom template and variable injection
- **PDF Generation**: Leverages Puppeteer for headless Chrome rendering with background preservation
- **Docker**: Provides consistent environment across different systems
- **Makefile**: Offers convenient targets for common operations

### Dependencies

- **Runtime**: Pandoc for HTML, Node.js/Puppeteer for PDF
- **Development**: Docker for containerized builds
- **Assets**: WebP images for optimized file sizes

### Troubleshooting

- **HTML generation fails**: Ensure Pandoc is installed and all content files exist
- **PDF generation fails**: Check Node.js version and Puppeteer installation
- **Docker issues**: Verify Docker is running and image is built
- **Styling issues**: Check browser compatibility and print CSS

### Version Control

- Commit content changes separately from build artifacts
- The `dist/` folder is typically gitignored (generated files)
- Keep template and build scripts under version control

## Features

- **Modular Content**: Separate files for easy maintenance and updates
- **VS Code Theme**: Dark theme for screen, professional for print
- **Responsive Design**: Works on desktop and mobile devices
- **Print Optimized**: A4 format with proper margins and print-friendly styling
- **Automated Builds**: Scripts and Makefile for consistent generation
- **Docker Support**: Containerized PDF generation for reproducibility
- **Background Preservation**: PDF generation maintains all visual styling
- **Semantic HTML**: Proper HTML5 structure for accessibility
