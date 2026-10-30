class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
    sha256 "2899b9ad56377869b003b83d0b4372e3426d94f3dad8fe9ac4fc3fdd6c4bcb05"
  end
  on_intel do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
    sha256 "6f0727be9129fbc3f1674c9ea6df88192aa6d6d17311fd52deda7c08f39c03bd"
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
