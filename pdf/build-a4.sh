#!/usr/bin/env bash
set -euo pipefail

IN="${1:-cv.md}"
OUT_DIR="pdf/dist"
OUT_PDF="$OUT_DIR/cv-A4.pdf"

if [[ ! -f "$IN" ]]; then
  echo "ERROR: Input file '$IN' not found. Expected cv.md in repo root."
  exit 1
fi

mkdir -p "$OUT_DIR"

# Extract first H1 as title (strip leading '# ' and trailing spaces)
TITLE="$(grep -m1 '^# ' "$IN" | sed 's/^# *//' | sed 's/[[:space:]]*$//')"
if [[ -z "${TITLE:-}" ]]; then
  TITLE="Curriculum Vitae"
fi

echo "Building A4 PDF from: $IN"
echo "Detected title: '$TITLE'"
echo "Output: $OUT_PDF"

# Use A4 geometry with 20mm margins
MARGIN="${MARGIN:-a4paper,margin=20mm}"

PANDOC_ARGS=(
  "--from=gfm"
  "--standalone"
  "--resource-path=.:assets"
  "--pdf-engine=xelatex"
  "-V" "geometry:$MARGIN"
  "--metadata" "title=$TITLE"
  "--output=$OUT_PDF"
  "$IN"
)

# Warn if photo is missing (non-fatal)
if [[ ! -f "assets/photo.jpg" && ! -f "assets/photo.png" ]]; then
  echo "WARN: No assets/photo.jpg (or .png) found. The CV image may not appear."
fi

run_pandoc_docker() {
  echo "Building custom pandoc Docker image..."
  echo "Running: docker build -t cv-pandoc ./pdf/"
  docker build -t cv-pandoc ./pdf/
  
  echo "Converting WebP images to JPEG..."
  # Convert any .webp images to .jpg for LaTeX compatibility
  if ls assets/*.webp >/dev/null 2>&1; then
    for webp_file in assets/*.webp; do
      if [ -f "$webp_file" ]; then
        jpg_file="${webp_file%.webp}.jpg"
        echo "Converting $webp_file to $jpg_file"
        docker run --rm \
          -v "$(pwd)":/work \
          -w /work \
          --entrypoint="" \
          cv-pandoc \
          dwebp "$webp_file" -o "$jpg_file"
      fi
    done
    
    # Update the Markdown to reference .jpg instead of .webp
    sed -i.bak 's/\.webp)/.jpg)/g' "$IN"
    echo "Updated image references in $IN (backup: ${IN}.bak)"
  fi
  
  echo "Running pandoc via custom Docker image..."
  echo "Running: docker run --rm -v $(pwd):/work -w /work cv-pandoc ${PANDOC_ARGS[@]}"
  docker run --rm \
    -v "$(pwd)":/work \
    -w /work \
    cv-pandoc \
    "${PANDOC_ARGS[@]}"
    
  # Restore original markdown file if we made changes
  if [ -f "${IN}.bak" ]; then
    mv "${IN}.bak" "$IN"
    echo "Restored original $IN"
  fi
}

if command -v docker >/dev/null 2>&1; then
  run_pandoc_docker
else
  echo "ERROR: Docker not found. Please install Docker Desktop to proceed."
  echo "Download from: https://www.docker.com/products/docker-desktop/"
  exit 1
fi

if [[ -f "$OUT_PDF" ]]; then
  echo "Success: $OUT_PDF"
else
  echo "ERROR: PDF not found at $OUT_PDF"
  exit 1
fi
