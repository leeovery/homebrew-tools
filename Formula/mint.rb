class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
      sha256 "d3bfb56c9f700ba8c77732be73ed1627f95fa93496ce1bed218097d2840e3020"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
      sha256 "917549dc7b3cf8438a073eb457b7443a38958e9cb2cdd4aae76e72f31fa901e6"
    end
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
