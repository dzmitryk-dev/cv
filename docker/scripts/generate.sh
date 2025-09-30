#!/bin/bash

# Generate CV files using Docker
set -e

echo "📄 Generating CV files using Docker..."

# Ensure dist directory exists
mkdir -p ./dist

# Run the CV generator using simple docker run
# Mount current directory as source and dist as output
docker run --rm \
  -v "$(pwd):/workspace:ro" \
  -v "$(pwd)/dist:/app/dist" \
  cv-generator:latest \
  sh -c "
    # Copy only the content files to working directory
    # Don't copy scripts/node_modules - use the ones built into the image
    cp /workspace/*.md /app/ 2>/dev/null || true
    cp /workspace/*.yml /app/ 2>/dev/null || true
    cp /workspace/*.webp /app/ 2>/dev/null || true
    cp -r /workspace/template /app/ 2>/dev/null || true
    
    # Use the build_html.sh from the image, but copy the build_html.sh from workspace if it exists
    if [ -f '/workspace/build_html.sh' ]; then
      cp /workspace/build_html.sh /app/
      chmod +x /app/build_html.sh
    fi
    
    # Run the build script
    /app/build_html.sh
    
    # Generate PDF
    node pdf/generate-pdf.js
  "

echo "✅ CV generation completed!"
echo "📁 Files generated in: ./dist/"

# List generated files
if [ -f "./dist/cv.html" ]; then
  echo "   ✅ cv.html (Web version)"
else
  echo "   ❌ cv.html (Failed to generate)"
fi

if [ -f "./dist/cv.pdf" ]; then
  echo "   ✅ cv.pdf (PDF with preserved styling)"
else
  echo "   ❌ cv.pdf (Failed to generate)"
fi