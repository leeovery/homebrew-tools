class Tick < Formula
  desc "Priority-based task scheduling CLI"
  homepage "https://github.com/leeovery/tick"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_arm64.tar.gz"
      sha256 "f32a88ac97d59ca2dfd97144deec1b668d91776d10f3a865bd815361eb7a6d58"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/tick/releases/download/v#{version}/tick_#{version}_darwin_amd64.tar.gz"
      sha256 "46cf9274005a0ce3a634e2ee70b59929109a3a4ad7d3502851d1a52406c95072"
    end
  end

  def install
    bin.install "tick"
  end

  test do
    assert_match "tick", shell_output("#{bin}/tick")
  end
end
