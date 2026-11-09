class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.5.4"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "3d7599ffa979a0a69c872213e158eccad5edea5ffce6b32c14769136d704a2fc"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "af7f8b8232994d8ddc4510b2bab94ce345f1861a53ded87fc27afb503998463a"
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
