# Makefile for CV Generation

.PHONY: html image pdf clean help

# Default target
help:
	@echo "Available targets:"
	@echo "  html   - Generate HTML CV page"
	@echo "  image  - Build Docker image"
	@echo "  pdf    - Generate PDF via Docker"
	@echo "  clean  - Clean generated files (dist folder)"
	@echo "  help   - Show this help message"

# Generate HTML CV
html:
	@echo "Generating HTML CV..."
	./build_html.sh

# Build Docker image
image:
	@echo "Building Docker image..."
	./docker/scripts/build.sh

# Generate PDF via Docker
pdf:
	@echo "Generating PDF via Docker..."
	./docker/scripts/generate.sh

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	rm -rf dist/*