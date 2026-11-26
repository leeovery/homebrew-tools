class Terrace < Formula
  desc "Shared, gated infrastructure runs for you and your AI agent"
  homepage "https://github.com/leeovery/terrace"
  version "0.0.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/terrace/releases/download/v#{version}/terrace_#{version}_darwin_arm64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end
  on_intel do
    url "https://github.com/leeovery/terrace/releases/download/v#{version}/terrace_#{version}_darwin_amd64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    bin.install "terrace"
  end

  test do
    assert_match "terrace #{version}", shell_output("#{bin}/terrace --version")
  end
end
