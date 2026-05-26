class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.5.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "26d543c12d68f68282c3ababe2e650ffe99264cf9553ebceedb5a5eac99b3096"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "cb0d3fe7017b9172bb57625609032f8e71748caa94966565a06a0e2c68c93c2e"
    end
  end

  def install
    bin.install "portal"
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
