class Tick < Formula
  desc "Priority-based task scheduling CLI"
  homepage "https://github.com/leeovery/tick"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_arm64.tar.gz"
      sha256 "2061dc4093eb5e04e472e4d481374205c350961f3b30a683442923db3b862ebd"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_amd64.tar.gz"
      sha256 "3a8aaa0f4a4ee70bc6e6037438573e9cc0df4700759b8b98dc84aab77d08b31a"
    end
  end

  def install
    bin.install "tick"
  end

  test do
    assert_match "tick", shell_output("#{bin}/tick")
  end
end
