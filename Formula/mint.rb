class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
      sha256 "286e0a7999263d8c4be631207c737e3bc68d1fe5978ae5158813b7acf7b27d2d"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
      sha256 "8f34d8159196c6850f2f436fa91120e54666239ac95b63098b9917a0fe89814d"
    end
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
