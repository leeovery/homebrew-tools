class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.7.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "6121f731edff46f882a45829329b811ec819614fb975d3b70446a9efd79154ec"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "f5ca7cf26c07ae4743bbbd65a082d53dea8eed52d0b229e100bdadf5b4722d97"
    end
  end

  def install
    bin.install "portal"
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
