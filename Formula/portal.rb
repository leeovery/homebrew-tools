class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.5.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "a3f5063fb9affc76aa53cedd9d1f166508bcd73e2aa540a5ba029387c191d8f5"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "e7092bc4a3b029c08016663cf8e95ce0562b2a4714a3643dce6e908b46c2e960"
    end
  end

  def install
    bin.install "portal"
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
