.PHONY: pdf clean help

# Default target
pdf:
	@./pdf/build.sh

# Clean build outputs
clean:
	@rm -rf pdf/dist/
	@echo "Cleaned pdf/dist/"

# A4 variant with custom geometry
pdf-a4:
	@./pdf/build-a4.sh

# Help target
help:
	@echo "Available targets:"
	@echo "  pdf      - Build CV PDF using Docker (default)"
	@echo "  pdf-a4   - Build A4 variant with 20mm margins"
	@echo "  clean    - Remove build outputs"
	@echo "  help     - Show this help"
	@echo ""
	@echo "Requirements: Docker Desktop must be installed and running"
