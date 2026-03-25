# Homebrew Formula Setup

This directory contains the initial Homebrew formula template.

## Initial Setup (First Time Only)

Follow these steps to set up the Homebrew tap for the first time:

### 1. Create a Release

First, ensure you've pushed all changes and create a release:

```bash
# Commit and push all changes
git add .
git commit -m "Add Homebrew support"
git push origin main

# Create and push the v2.0.0 tag
git tag -a v2.0.0 -m "Release v2.0.0"
git push origin v2.0.0
```

Wait for the GitHub Actions workflow to complete building all binaries.

### 2. Get SHA256 Checksums

Download the checksums file from the release:

```bash
curl -sL https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/checksums.txt
```

You'll see output like:
```
abc123... dns-switch-darwin-amd64.tar.gz
def456... dns-switch-darwin-arm64.tar.gz
ghi789... dns-switch-linux-amd64.tar.gz
jkl012... dns-switch-linux-arm64.tar.gz
```

### 3. Update the Formula

Edit `dns-switch.rb` in this directory and replace the placeholder SHA256 values:

```ruby
sha256 "REPLACE_WITH_ACTUAL_SHA256_ARM64"      # Use the darwin-arm64 checksum
sha256 "REPLACE_WITH_ACTUAL_SHA256_AMD64"      # Use the darwin-amd64 checksum
sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_ARM64" # Use the linux-arm64 checksum
sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_AMD64" # Use the linux-amd64 checksum
```

### 4. Add Formula to Tap Repository

Clone your tap repository and add the formula:

```bash
# Clone the tap repository
git clone https://github.com/pinaka-io/homebrew-tap.git
cd homebrew-tap

# Create Formula directory if it doesn't exist
mkdir -p Formula

# Copy the updated formula
cp /path/to/dns-switch/homebrew/dns-switch.rb Formula/

# Commit and push
git add Formula/dns-switch.rb
git commit -m "Add dns-switch formula"
git push origin main
```

### 5. Set Up GitHub Token

For automatic updates to work, create a GitHub Personal Access Token:

1. Go to: https://github.com/settings/tokens/new
2. Name: `TAP_GITHUB_TOKEN`
3. Select scope: `repo` (full control)
4. Click "Generate token" and copy it

Then add it as a repository secret:

1. Go to: https://github.com/pinaka-io/dns-switch/settings/secrets/actions
2. Click "New repository secret"
3. Name: `TAP_GITHUB_TOKEN`
4. Value: Paste your token
5. Click "Add secret"

### 6. Test Installation

Now users can install via Homebrew:

```bash
# Add the tap
brew tap pinaka-io/tap

# Install
brew install dns-switch

# Test
dns-switch --version
```

## Future Releases (Automatic)

For all future releases, the process is automatic:

1. Create and push a new tag:
   ```bash
   git tag -a v2.1.0 -m "Release v2.1.0"
   git push origin v2.1.0
   ```

2. GitHub Actions will automatically:
   - Build binaries for all platforms
   - Create a GitHub release
   - Update the Homebrew formula in the tap repository with new checksums

No manual intervention needed! 🎉

## Troubleshooting

### Formula won't install

Check the formula syntax:
```bash
brew audit --strict homebrew-tap/Formula/dns-switch.rb
```

### Wrong checksums

Verify checksums match the release:
```bash
curl -sL https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/checksums.txt
```

### Automatic update not working

Check:
- GitHub secret `TAP_GITHUB_TOKEN` is set
- Token has `repo` permissions
- Workflow file `.github/workflows/update-homebrew.yml` exists

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Creating a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- See `docs/HOMEBREW.md` for detailed documentation
