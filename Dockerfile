# Use official Pandoc image as base
FROM pandoc/core:latest

# Switch to root to install packages
USER root

# Install Node.js and system dependencies for Puppeteer
RUN apk add --no-cache \
    # Node.js and npm
    nodejs \
    npm \
    # Dependencies for Puppeteer/Chromium
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    # Additional utilities
    bash \
    && rm -rf /var/cache/apk/*

# Create app directory
WORKDIR /app

# Install Puppeteer directly
RUN npm install puppeteer@^24.22.3

# Set Puppeteer to use system Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/lib/chromium/chromium

# Copy application files
COPY . .

# Create dist directory and fix permissions
RUN mkdir -p dist

# Make build script executable
RUN chmod +x build.sh

# Stay as root for simplicity (can be changed later for security)

# Expose port is not needed for file generation only
# EXPOSE 8000

# Override the pandoc entrypoint to use bash instead
ENTRYPOINT []

# Default command - build the CV
CMD ["./build.sh"]

# Add labels for metadata
LABEL maintainer="Dzmitry Kalianchuk"
LABEL description="CV Generator with Pandoc and Puppeteer PDF export"
LABEL version="1.0.0"