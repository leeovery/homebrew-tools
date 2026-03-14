class Tick < Formula
  desc "Priority-based task scheduling CLI"
  homepage "https://github.com/leeovery/tick"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_arm64.tar.gz"
      sha256 "3d4e9e41f2ac9cfc48b2d76e685845c12fdbba5179a8f79b31cfe86ed31e9cc9"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_amd64.tar.gz"
      sha256 "32cffaddc2c17d287fd8158e08297a787ebbadbecb38e47f3f15a79807e649e2"
    end
  end

  def install
    bin.install "tick"
  end

  test do
    assert_match "tick", shell_output("#{bin}/tick")
  end
end
