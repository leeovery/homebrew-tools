class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.2.9"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
    sha256 "b5e32df73aaf226d357d159a8b5547dda3c6ee32c42ffa03d0c5fc534d9b0796"
  end
  on_intel do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
    sha256 "8f9e99856c6d637a4906bc8add9ad6db417534176cf6eb011d9d5e34a6bd1de3"
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
