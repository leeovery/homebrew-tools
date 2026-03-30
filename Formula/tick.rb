class Tick < Formula
  desc "Priority-based task scheduling CLI"
  homepage "https://github.com/leeovery/tick"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_arm64.tar.gz"
      sha256 "127d161c8344b8e8403ab21f68a2211e29985fb143f3d54ab2d96419ab35cfd8"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_amd64.tar.gz"
      sha256 "2e7d115c7a391f2d4200bb99d43cb7153394ac77de5a272df95c6e8dfad06fdc"
    end
  end

  def install
    bin.install "tick"
  end

  test do
    assert_match "tick", shell_output("#{bin}/tick")
  end
end
