#!/bin/bash

# Docker CV Generator Build Script
# This script builds the Docker image for CV generation

set -e

echo "🐳 Building CV Generator Docker image..."

# Build the Docker image
docker build -t cv-generator:latest -f docker/Dockerfile .

echo "✅ Docker image built successfully!"
echo ""
echo "📖 Usage:"
echo "  ./docker/scripts/build.sh     - Build Docker image"
echo "  ./docker/scripts/generate.sh  - Generate CV files (HTML + PDF)"