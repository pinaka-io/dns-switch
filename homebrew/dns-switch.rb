# This file should be placed in the homebrew-tap repository at:
# Formula/dns-switch.rb
#
# Initial setup:
# 1. Create release first: git tag -a v2.0.0 -m "Release v2.0.0" && git push origin v2.0.0
# 2. Wait for release to build
# 3. Download checksums.txt from the release
# 4. Replace the SHA256 placeholders below with actual values
# 5. Copy this file to homebrew-tap/Formula/dns-switch.rb
# 6. Commit and push to the tap repository
#
# After initial setup, the update-homebrew.yml workflow will automatically
# update this formula for future releases.

class DnsSwitch < Formula
  desc "Fast, user-friendly TUI for quickly switching between DNS configurations"
  homepage "https://github.com/pinaka-io/dns-switch"
  version "2.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/dns-switch-darwin-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_ARM64"
    else
      url "https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/dns-switch-darwin-amd64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_AMD64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/dns-switch-linux-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_ARM64"
    else
      url "https://github.com/pinaka-io/dns-switch/releases/download/v2.0.0/dns-switch-linux-amd64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256_LINUX_AMD64"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "dns-switch-darwin-arm64" => "dns-switch"
      else
        bin.install "dns-switch-darwin-amd64" => "dns-switch"
      end
    else
      if Hardware::CPU.arm?
        bin.install "dns-switch-linux-arm64" => "dns-switch"
      else
        bin.install "dns-switch-linux-amd64" => "dns-switch"
      end
    end
  end

  def caveats
    <<~EOS
      DNS Switch requires sudo to modify network settings:
        sudo dns-switch

      Configuration file location:
        ~/.config/dns-switch/config.yaml
    EOS
  end

  test do
    assert_match "dns-switch", shell_output("#{bin}/dns-switch --version")
  end
end
