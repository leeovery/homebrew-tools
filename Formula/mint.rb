class Mint < Formula
  desc "AI-minted releases and commits"
  homepage "https://github.com/leeovery/mint"
  version "0.0.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_arm64.tar.gz"
      sha256 "d030b7a6b6b963838a9c79b761906c919db796cc0f1c4e90bea88ec6c2b7a3d5"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/mint/releases/download/v#{version}/mint_#{version}_darwin_amd64.tar.gz"
      sha256 "1eb455c530b7ab8236d442cca6bd40c70ea97c067cb8145881b5b0650a52ef64"
    end
  end

  def install
    bin.install "mint"
  end

  test do
    assert_match "usage: mint", shell_output("#{bin}/mint help")
  end
end
