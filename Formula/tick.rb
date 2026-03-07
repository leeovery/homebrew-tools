class Tick < Formula
  desc "Priority-based task scheduling CLI"
  homepage "https://github.com/leeovery/tick"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_arm64.tar.gz"
      sha256 "7a98fb26f2ff7729c134578b9007b275bc385cad942a027c75d6b850ec0dca0c"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_amd64.tar.gz"
      sha256 "01dd51c3f24331e101710d460301e0bc4173580ef2634a89aa0414da74097ab4"
    end
  end

  def install
    bin.install "tick"
  end

  test do
    assert_match "tick", shell_output("#{bin}/tick")
  end
end
