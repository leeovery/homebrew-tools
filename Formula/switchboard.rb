class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.8.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "cfd26b0a38e2a37bf38f2097365ebb2963dca66e5d94701f9bd976ff98e1a844"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "6ad21e364f7e6dcd31ad5d03a4603dd50a5dd000ce24455f2fe64024c1e991a0"
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
