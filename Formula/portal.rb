class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "5e38d3527c3ce571e1870ecf52d7bca8ba3840470f3f439a1addcf4cd1d7bcd0"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "4bf393a32aa3a6c09251e6ad43009838a7f0441087f7fe3f55a39907ad66cb2c"
    end
  end

  def install
    bin.install "portal"
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
