# GitHub Actions CI/CD for CV Generator

This repository now includes automated CV generation and release publishing using GitHub Actions. The workflows will automatically build your CV in both HTML and PDF formats and make them available for download.

## 🔄 Available Workflows

### 1. CV Release Workflow (`cv-release.yml`)

**Purpose**: Generates CV files and creates a GitHub release with downloadable assets.

**Triggers**:
- **Git Tags**: Push a tag starting with `v` or `release-` (e.g., `v1.0`, `release-2024-01`)
- **Manual Trigger**: Run from GitHub Actions tab with custom options
- **Content Changes** (optional): Uncomment the push trigger to auto-release on content updates

**Generated Assets**:
- `CV.pdf` - Latest PDF version
- `CV.html` - Latest HTML version  
- `CV-YYYYMMDD.pdf` - Dated PDF version
- `CV-YYYYMMDD.html` - Dated HTML version

### 2. Build Test Workflow (`cv-build-test.yml`)

**Purpose**: Tests CV generation on pull requests and content changes without creating releases.

**Triggers**:
- Pull requests affecting CV content or templates
- Pushes to main/master branch affecting CV files

**Outputs**:
- Build artifacts available for download from Actions tab
- Validation of HTML and PDF generation

## 🚀 How to Use

### Creating a Release (Method 1: Git Tags)

1. **Create and push a tag**:
   ```bash
   git tag v1.0
   git push origin v1.0
   ```

2. **The workflow will automatically**:
   - Build HTML and PDF versions
   - Create a GitHub release
   - Upload files as downloadable assets

3. **Access your CV**:
   - Go to the "Releases" section of your repository
   - Download the PDF or HTML files
   - Share the direct download links

### Creating a Release (Method 2: Manual Trigger)

1. **Go to GitHub Actions tab** in your repository
2. **Select "Generate CV and Create Release"**
3. **Click "Run workflow"**
4. **Configure options** (optional):
   - Custom release name
   - Mark as pre-release
5. **Click "Run workflow"** to start

### Testing Changes

- **Pull Requests**: Automatically tested when you open a PR
- **Content Updates**: Automatically tested when you push to main/master
- **Manual Testing**: Run the "Build and Test CV" workflow manually

## 📁 File Access

### Direct Download Links

Once a release is created, you can access files via direct links:

```
https://github.com/USERNAME/REPOSITORY/releases/latest/download/CV.pdf
https://github.com/USERNAME/REPOSITORY/releases/latest/download/CV.html
```

Replace `USERNAME` and `REPOSITORY` with your GitHub username and repository name.

### Release Page

Visit the releases page for a complete overview:
```
https://github.com/USERNAME/REPOSITORY/releases
```

## 🔧 Configuration

### Customizing Triggers

You can modify the workflow triggers in `.github/workflows/cv-release.yml`:

**Enable automatic releases on content changes**:
```yaml
# Uncomment these lines in cv-release.yml
push:
  branches: [ main, master ]
  paths:
    - 'content/**'
    - 'template/**'
```

**Change tag patterns**:
```yaml
push:
  tags:
    - 'v*'           # Tags like v1.0, v2.1
    - 'release-*'    # Tags like release-2024-01
    - 'cv-*'         # Tags like cv-latest
```

### Customizing Release Content

Edit the release body in the workflow file to change the description format.

### Adding Dependencies

If you add new Node.js dependencies, update `package.json` and the workflow will automatically install them.

## 🛠️ Troubleshooting

### Common Issues

1. **Workflow fails with "Pandoc not found"**
   - The workflow installs Pandoc automatically
   - Check the workflow logs for installation errors

2. **PDF generation fails**
   - Ensure your HTML generates successfully first
   - Check for any CSS or content issues

3. **Release creation fails**
   - Ensure you have the `GITHUB_TOKEN` permissions
   - Check if tag already exists

4. **Files are empty or too small**
   - The workflow validates file sizes
   - Check your content files for issues

### Viewing Logs

1. Go to **Actions** tab in your repository
2. Click on the failed workflow run
3. Expand the failed step to see detailed logs

### Manual Testing

Test locally before pushing:
```bash
# Test HTML generation
./build_html.sh

# Test PDF generation  
npm install
node pdf/generate-pdf.js

# Check generated files
ls -la dist/
```

## 📊 Workflow Features

### Security
- Uses official GitHub Actions
- Minimal required permissions
- No external services required

### Performance
- Caches Node.js dependencies
- Parallel artifact uploads
- Efficient file handling

### Reliability
- File validation steps
- Error handling and reporting
- Comprehensive logging

### Flexibility
- Multiple trigger options
- Customizable release naming
- Optional pre-release marking

## 🎯 Best Practices

1. **Use semantic versioning** for tags: `v1.0.0`, `v1.1.0`, etc.
2. **Test changes** using pull requests before merging
3. **Keep content files focused** on their specific sections
4. **Use descriptive commit messages** for better release notes
5. **Review generated files** by downloading artifacts from test runs

## 🔗 Integration Tips

### Sharing Your CV

- **Direct PDF link**: Share the latest download URL
- **Portfolio website**: Embed the HTML version or link to releases
- **Email applications**: Attach the downloaded PDF
- **LinkedIn**: Link to your latest release

### Automation Ideas

- **Scheduled updates**: Add cron triggers for periodic releases
- **Slack notifications**: Add webhook notifications for new releases
- **Multiple formats**: Extend to generate DOCX or other formats
- **Multi-language**: Create separate workflows for different languages

---

Your CV is now automatically built and published! 🎉