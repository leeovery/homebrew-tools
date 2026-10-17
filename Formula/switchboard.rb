class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
      sha256 "6be19b80964bbe56df00c8c3cf0758ca3ed10b409ca68526d648d4b30517a18b"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
      sha256 "89a124c9f15d52ffc6f51e5210bc9b5f32c6af86b03a1ff643908ce752ad1d94"
    end
  end

  def install
    bin.install "switchboard"
  end

  def caveats
    <<~EOS
      To set switchboard up, run:

        switchboard setup

      It walks through your accounts and their tokens, priming, the service
      that keeps the router running, the claude link (with the one line to add
      to your shell's startup file) and the Claude Code skill.
    EOS
  end

  test do
    assert_match "switchboard version", shell_output("#{bin}/switchboard --version")
  end
end
