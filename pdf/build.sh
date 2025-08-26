#!/usr/bin/env bash
set -euo pipefail

# Configuration
INPUT_FILE="${1:-cv.md}"
OUTPUT_DIR="pdf/dist"
OUTPUT_FILE="$OUTPUT_DIR/dzmitry_kalianchuk_android_cv.pdf"
DOCKER_IMAGE="cv-pandoc"

echo "=== CV PDF Builder ==="
echo "Input: $INPUT_FILE"
echo "Output: $OUTPUT_FILE"

# Validate input file
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "ERROR: Input file '$INPUT_FILE' not found. Expected cv.md in repo root."
  exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check if Docker is available
if ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: Docker not found. Please install Docker Desktop to proceed."
  echo "Download from: https://www.docker.com/products/docker-desktop/"
  exit 1
fi

# Build Docker image if it doesn't exist
if ! docker image inspect "$DOCKER_IMAGE" >/dev/null 2>&1; then
  echo "Building Docker image '$DOCKER_IMAGE'..."
  docker build -t "$DOCKER_IMAGE" ./pdf/
fi

# Run the conversion in Docker container
echo "Running PDF conversion..."
docker run --rm \
  -v "$(pwd)":/work \
  -w /work \
  -e MARGIN="${MARGIN:-a4paper,margin=20mm}" \
  "$DOCKER_IMAGE" \
  "$INPUT_FILE" \
  "$OUTPUT_FILE"

# Verify result
if [[ -f "$OUTPUT_FILE" ]]; then
  echo ""
  echo "✅ Success: $OUTPUT_FILE"
  echo "📄 File size: $(ls -lh "$OUTPUT_FILE" | awk '{print $5}')"
else
  echo "❌ ERROR: PDF not found at $OUTPUT_FILE"
  exit 1
fi
