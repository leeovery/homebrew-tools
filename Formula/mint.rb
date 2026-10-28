class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.1.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
    sha256 "bb3a7932100134d3c315937f6d475776121550037e9de5aef8d5e7cc211104e3"
  end
  on_intel do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
    sha256 "e2ec2e5f33ac351ce63ec96850434c609974bf9d151aafdc5042d2e5b1dda4c1"
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
