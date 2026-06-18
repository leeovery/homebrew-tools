class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.0.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
      sha256 "f2376a0d75feba2bc5fc90b8d4e23971ee18f16604f7f5c0ddf0741d2e0d5d7b"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
      sha256 "f79d3a4dae171579dc5bf941b8f8df6c499f1d8fb4cc0dbbde4e5d515eb09fed"
    end
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
