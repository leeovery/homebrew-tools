class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "1.3.3"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "c453d7092af94fde9e90f107ab9662bda1315dca9db1b78225e9538742d9193d"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "ff2232eea20174ad18de0f242bc84e664eeffdce91e73d1a4d02363692c7daf0"
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
