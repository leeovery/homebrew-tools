class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.5.1"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "961e31fa882d539659cc37da47d360e3c6e14189aa619cba609e6ab85a35e24c"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "4c4447469ef90ff9a6a24478372e6dc854f986426f07b7845c61045bd12baf28"
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
