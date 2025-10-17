#!/bin/bash

# Build CV from separate components
echo "Building CV from separate markdown files..."

# Get current date
CURRENT_DATE=$(date +"%Y-%m-%d")

# Build with all components and auto-generated date
pandoc content/meta.yml content/contacts.yml content/skills.yml \
  --variable summary:"$(cat content/summary.md)" \
  --variable achievements:"$(pandoc content/achievements.md --to html)" \
  --variable responsibilities:"$(pandoc content/responsibilities.md --to html)" \
  --variable strengths:"$(pandoc content/strengths.md --to html)" \
  --variable experience:"$(pandoc content/experience.md --to html)" \
  --variable education:"$(pandoc content/education.md --to html)" \
  --variable languages:"$(pandoc content/languages.md --to html)" \
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