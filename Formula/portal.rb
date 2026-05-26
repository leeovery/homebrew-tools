class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.5.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "be1e9c4d579e8e517838823a61ccdc737c166ee6dbd7902fab99415e28027b04"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "7b669dd079ce71e2a410e91f2f3628476cc28a79703fc97ff8df7b515777c0b8"
    end
  end

  def install
    bin.install "portal"
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
