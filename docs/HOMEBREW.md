# Homebrew Tap Setup

This document explains how the Homebrew tap integration works and how to maintain it.

## Overview

DNS Switch is distributed via a custom Homebrew tap at:
- **Tap Repository:** https://github.com/pinaka-io/homebrew-tap
- **Formula:** `Formula/dns-switch.rb`

## Installation for Users

```bash
# Add the tap
brew tap pinaka-io/tap

# Install dns-switch
brew install dns-switch

# Run
sudo dns-switch
```

## How It Works

### Automatic Updates

When a new release is created (by pushing a version tag), the `update-homebrew.yml` workflow automatically:

1. Downloads the checksums from the release
2. Extracts SHA256 hashes for all platform binaries
3. Updates the formula in the tap repository
4. Commits and pushes the changes

### Manual Formula Update

If the automatic workflow fails, you can manually update the formula:

1. Clone the tap repository:
   ```bash
   git clone https://github.com/pinaka-io/homebrew-tap.git
   cd homebrew-tap
   ```

2. Download checksums from the release:
   ```bash
   curl -sL https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/checksums.txt -o checksums.txt
   ```

3. Extract checksums:
   ```bash
   grep "dns-switch-darwin-amd64.tar.gz" checksums.txt | awk '{print $1}'
   grep "dns-switch-darwin-arm64.tar.gz" checksums.txt | awk '{print $1}'
   grep "dns-switch-linux-amd64.tar.gz" checksums.txt | awk '{print $1}'
   grep "dns-switch-linux-arm64.tar.gz" checksums.txt | awk '{print $1}'
   ```

4. Update `Formula/dns-switch.rb` with:
   - New version number
   - New release URLs
   - New SHA256 checksums

5. Commit and push:
   ```bash
   git add Formula/dns-switch.rb
   git commit -m "Update dns-switch to 2.0.0"
   git push
   ```

## Formula Structure

The formula supports:
- **macOS:** Intel (amd64) and Apple Silicon (arm64)
- **Linux:** amd64 and arm64

Each platform downloads the appropriate binary and installs it to `$(brew --prefix)/bin/dns-switch`.

## Testing the Formula

Test the formula locally before releasing:

```bash
# Audit the formula
brew audit --strict Formula/dns-switch.rb

# Test installation
brew install --build-from-source Formula/dns-switch.rb

# Test the installed binary
dns-switch --version

# Uninstall
brew uninstall dns-switch
```

## GitHub Token Setup

For the automatic workflow to work, you need a GitHub Personal Access Token with `repo` permissions:

1. Create a token at: https://github.com/settings/tokens/new
2. Select scope: `repo` (full control of private repositories)
3. Copy the token
4. Add it as a secret in the main repository:
   - Go to: https://github.com/pinaka-io/dns-switch/settings/secrets/actions
   - Click "New repository secret"
   - Name: `TAP_GITHUB_TOKEN`
   - Value: Paste your token

## Troubleshooting

### Formula fails to install

Check:
- Binary names match what's in the tarball
- SHA256 checksums are correct
- Release URLs are accessible

### Automatic update doesn't work

Check:
- `TAP_GITHUB_TOKEN` secret is set correctly
- Token has `repo` permissions
- Workflow has permission to push to tap repository

### Testing locally

```bash
# Install from local formula file
brew install --build-from-source /path/to/dns-switch.rb

# Or test without installing
brew test dns-switch.rb
```

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Tap Documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- [GitHub Actions - Homebrew](https://github.com/Homebrew/actions)
