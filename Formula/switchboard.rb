class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.2.6"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "d150171247df7e57a819b5b16e6acfdaa0db276785a7470d01b23fa482fe8657"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "8f2a11b5b757bf71d39e9e4a81d35f0a4c5255a105d1c80f027a39b31f9be0af"
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
