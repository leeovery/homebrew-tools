class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
      sha256 "0337464bddfec44f622163459c4bd8fb3611e35bf765f37eb6a63684de712ed2"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
      sha256 "3d7b36236065a68f48c4eba8076f610795da864d88a7b00e8305c7b86bcd9999"
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
