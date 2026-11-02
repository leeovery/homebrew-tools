class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.2.5"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
    sha256 "61340b91bdb99373bb02f4484d9f62543ce72a0a7bc368245847f54b26025efa"
  end
  on_intel do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
    sha256 "67d9d110d14b439ccfd179f37427d8ab85bfe224f62b6d3b7fe22c7f92fcfe5f"
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
