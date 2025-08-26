# CV as Code

My CV stored in Markdown with automated PDF generation.  
Built locally with Docker or automatically via GitHub Actions.

## 📂 Structure

```text
cv/
├── cv.md                # Main CV content
├── assets/              # Images (e.g. avatar.webp)
├── pdf/                 # Build tools & output
│   ├── build.sh
│   ├── Dockerfile
│   └── dist/            # Generated PDFs
└── .github/workflows/   # CI/CD pipeline
```

## 🚀 Usage

- **Generate PDF**: `make pdf`
- **Clean outputs**: `make clean`

## 🔧 Requirements
- Docker
- Git (optional)