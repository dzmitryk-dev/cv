# CV PDF Build

Build your CV PDF from `cv.md` using Docker.

## Prerequisites

- **Required:** Docker Desktop
- The scripts build and use a custom Docker image with pandoc and XeLaTeX.

## Setup

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Ensure Docker is running

## Run locally

```bash
./pdf/build.sh            # builds pdf/dist/cv.pdf from cv.md
./pdf/build.sh path/to/other.md
./pdf/build-a4.sh         # builds pdf/dist/cv-A4.pdf with A4 geometry

# Using Makefile shortcuts
make pdf                  # same as ./pdf/build.sh
make pdf-a4              # same as ./pdf/build-a4.sh
make clean               # remove pdf/dist/

# Custom margins via environment variable
MARGIN="margin=0.5in" ./pdf/build.sh
```

## CI

GitHub Actions workflow at `.github/workflows/pdf.yml` builds on push and uploads the PDF artifact (`cv-pdf`).

## Assets

Place your headshot at `assets/photo.jpg` (or `.png`). The Markdown includes it via an `<img>` tag.
