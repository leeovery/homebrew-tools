class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.2.7"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
    sha256 "61a6f11a96dfcf585b2bcf38e181e31c9e0d71acfb90643043ee28ec3cba6123"
  end
  on_intel do
    url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
    sha256 "c2dd64377eabd652d7b34cc4d3fc4c5dcbe6995df8cd29474ebb5643a8053038"
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
