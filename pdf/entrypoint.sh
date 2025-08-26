#!/bin/bash
set -euo pipefail

# Default values
INPUT_FILE="${1:-cv.md}"
OUTPUT_FILE="${2:-dzmitry_kalianchuk_android_cv.pdf}"
MARGIN="${MARGIN:-a4paper,margin=20mm}"

echo "=== CV PDF Builder ==="
echo "Input: $INPUT_FILE"
echo "Output: $OUTPUT_FILE"
echo "Margin: $MARGIN"

# Check if input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "ERROR: Input file '$INPUT_FILE' not found."
  exit 1
fi

# Create output directory
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Extract title from markdown
TITLE="$(grep -m1 '^# ' "$INPUT_FILE" | sed 's/^# *//' | sed 's/[[:space:]]*$//' || echo 'Curriculum Vitae')"
echo "Detected title: '$TITLE'"

# Convert WebP images to JPEG for LaTeX compatibility
echo "Converting WebP images to JPEG..."
TEMP_INPUT="$INPUT_FILE"
TEMP_ASSETS_DIR=""
NEEDS_CLEANUP=false

if ls assets/*.webp >/dev/null 2>&1; then
  # Create temporary assets directory inside container
  TEMP_ASSETS_DIR="/tmp/assets"
  mkdir -p "$TEMP_ASSETS_DIR"
  
  # Copy all assets to temp directory first
  cp -r assets/* "$TEMP_ASSETS_DIR/"
  
  # Convert WebP files in the temp directory
  for webp_file in "$TEMP_ASSETS_DIR"/*.webp; do
    if [ -f "$webp_file" ]; then
      jpg_file="${webp_file%.webp}.jpg"
      echo "Converting $(basename "$webp_file") to $(basename "$jpg_file") in container"
      dwebp "$webp_file" -o "$jpg_file"
    fi
  done
  
  # Create temporary markdown file with updated image references and temp asset path
  TEMP_INPUT="/tmp/$(basename "$INPUT_FILE")"
  # Update image references to point to temp directory and change .webp to .jpg
  sed "s|assets/\([^)]*\)\.webp|$TEMP_ASSETS_DIR/\1.jpg|g" "$INPUT_FILE" > "$TEMP_INPUT"
  NEEDS_CLEANUP=true
  echo "Updated image references to use temporary container directory"
fi

# Warn if photo is missing (non-fatal)
if [[ ! -f "assets/photo.jpg" && ! -f "assets/photo.png" ]]; then
  echo "WARN: No assets/photo.jpg (or .png) found. The CV image may not appear."
fi

# Build PDF with pandoc
echo "Building PDF..."

# Set resource path - use temp assets if we converted images, otherwise use original
RESOURCE_PATH=".:assets"
if [ -n "$TEMP_ASSETS_DIR" ]; then
  RESOURCE_PATH=".:$TEMP_ASSETS_DIR:assets"
fi

pandoc \
  --from=gfm \
  --standalone \
  --resource-path="$RESOURCE_PATH" \
  --pdf-engine=xelatex \
  -V "geometry:$MARGIN" \
  --metadata "title=$TITLE" \
  --output="$OUTPUT_FILE" \
  "$TEMP_INPUT"

# Cleanup temporary files
if [ "$NEEDS_CLEANUP" = true ]; then
  rm -f "$TEMP_INPUT"
  if [ -n "$TEMP_ASSETS_DIR" ]; then
    rm -rf "$TEMP_ASSETS_DIR"
    echo "Cleaned up temporary container files"
  fi
fi

# Verify output
if [[ -f "$OUTPUT_FILE" ]]; then
  echo "Success: $OUTPUT_FILE"
  ls -lh "$OUTPUT_FILE"
else
  echo "ERROR: PDF not found at $OUTPUT_FILE"
  exit 1
fi
