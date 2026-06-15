class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
      sha256 "77d07db6c22bbd5795c0437f5e1ec347bc8b04ba93487920111bbad4bec223f9"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
      sha256 "ece19442e165cfb8389f8fe490a24138ed103660452ca95d931ae0f240ec1514"
    end
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
