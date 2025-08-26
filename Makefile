.PHONY: pdf clean help

# Default target
pdf:
	@./pdf/build.sh

# Clean build outputs
clean:
	@rm -rf pdf/dist/
	@echo "Cleaned pdf/dist/"

# Help target
help:
	@echo "Available targets:"
	@echo "  pdf      - Build CV PDF with A4 geometry (default)"
	@echo "  clean    - Remove build outputs"
	@echo "  help     - Show this help"
	@echo ""
	@echo "Requirements: Docker Desktop must be installed and running"
