#!/usr/bin/env node

const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

async function generatePDF() {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || undefined,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-accelerated-2d-canvas',
            '--no-first-run',
            '--no-zygote',
            '--single-process',
            '--disable-gpu',
            '--disable-background-timer-throttling',
            '--disable-backgrounding-occluded-windows',
            '--disable-renderer-backgrounding',
            '--disable-features=TranslateUI',
            '--disable-ipc-flooding-protection',
            '--disable-software-rasterizer'
        ]
    });

    try {
        const page = await browser.newPage();

        // Path to the generated HTML file
        const htmlPath = path.join(__dirname, '..', 'dist', 'cv.html');
        const outputPath = path.join(__dirname, '..', 'dist', 'dzmitry_kalianchuk_cv.pdf');

        // Check if HTML file exists
        if (!fs.existsSync(htmlPath)) {
            console.error('❌ HTML file not found. Run ./build.sh first to generate cv.html');
            process.exit(1);
        }

        console.log('📄 Loading CV HTML file...');

        // Load the HTML file
        await page.goto(`file://${htmlPath}`, {
            waitUntil: 'networkidle0'
        });

        // Wait for fonts to load
        await page.evaluateHandle('document.fonts.ready');

        // Wait a bit more for any dynamic content
        await new Promise(resolve => setTimeout(resolve, 1000));

        console.log('🎨 Generating PDF with preserved backgrounds and styling...');

        // Generate PDF with optimized margins and CSS page control
        await page.pdf({
            path: outputPath,
            format: 'A4',
            margin: {
                top: '10mm',
                right: '10mm',
                bottom: '10mm',
                left: '10mm'
            },
            printBackground: true, // This is the key setting!
            preferCSSPageSize: false,
            displayHeaderFooter: false
        });

        console.log(`✅ PDF generated successfully: ${outputPath}`);
        console.log('🎉 All backgrounds and styling preserved!');

    } catch (error) {
        console.error('❌ Error generating PDF:', error);
        process.exit(1);
    } finally {
        await browser.close();
    }
}

// Run the function
generatePDF().catch(error => {
    console.error('❌ Fatal error:', error);
    process.exit(1);
});