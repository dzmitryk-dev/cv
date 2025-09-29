#!/bin/bash

# Build CV from separate components
echo "Building CV from separate markdown files..."

# Get current date
CURRENT_DATE=$(date +"%Y-%m-%d")

# Build with all components and auto-generated date
pandoc meta.yml contacts.yml skills.yml \
  --variable summary:"$(cat summary.md)" \
  --variable achievements:"$(pandoc achievements.md --to html)" \
  --variable experience:"$(pandoc experience.md --to html)" \
  --variable education:"$(pandoc education.md --to html)" \
  --variable languages:"$(pandoc languages.md --to html)" \
  --variable date:"$CURRENT_DATE" \
  --template=template/cv.html \
  --standalone \
  --output=dist/cv.html

echo "✅ CV built successfully at dist/cv.html"
echo "📅 Generated with date: $CURRENT_DATE"

# Optional: Open the result
if [[ "$1" == "--open" ]]; then
    open dist/cv.html
fi