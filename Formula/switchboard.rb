class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "1.0.3"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "dea296ec16aab0f7416df47ee093cf1a4a4c5836d02246ab9ce8308af888c04b"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "2a54f5241d1e1ca9a6b2d440a1d30d65d670d0fbcc5e71e876e6914f3c19d9b5"
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
