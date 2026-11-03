class Switchboard < Formula
  desc "Spread Claude Code sessions across several Claude subscriptions"
  homepage "https://github.com/leeovery/switchboard"
  version "0.4.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_arm64.tar.gz"
    sha256 "b36c5e46c95185d0c28062453ff990ef8bcc229a349c8c7fb14f989514b0259a"
  end
  on_intel do
    url "https://github.com/leeovery/switchboard/releases/download/v#{version}/switchboard_#{version}_darwin_amd64.tar.gz"
    sha256 "b022a69a3dfc4a5825aa802bb3051052360711c385aaefd65b421152c42a8ba4"
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
