class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.5.3"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "4c090378957aa2b4d52c38062d8f4d414fa11315cee40ce6c6837b092be4f6ff"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "c5755f33ecca56b582c51d16abb61180d516a66984603760c929dd93eeb247e4"
  end

  def install
    bin.install "switchboard"
  end

  def caveats
    <<~EOS
      To set switchboard up, run:

        switchboard setup

      It walks through your accounts and their tokens, priming, the service
      that keeps the router running, the claude link and the line in your
      shell's startup file that puts it first, and the Claude Code skill.

      To take it away again, run this before brew uninstall:

        switchboard uninstall

      It keeps your config, tokens and history for a reinstall, unless you
      add --all.
    EOS
  end

  test do
    assert_match "switchboard version", shell_output("#{bin}/switchboard --version")
  end
end
