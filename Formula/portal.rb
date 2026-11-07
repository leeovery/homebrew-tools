class Portal < Formula
  desc "Interactive session picker for zmx"
  homepage "https://github.com/leeovery/portal"
  version "0.12.6"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "f93edef646f3dccb325bb55e5b85db1d061a7971d36946853f91ccd0f029d1f8"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "b7c3dda1a7881a13fdb046d5c2dba8135e18d559902baf62815347522cf85577"
  end

  def install
    bin.install "portal"
  end

  def caveats
    <<~EOS
      Coming from the tmux version of Portal? Run this once, before anything else:

        portal migrate

      To activate shell integration, add to your ~/.zshrc:

        eval "$(portal init zsh)"

      For bash: eval "$(portal init bash)"
      For fish: portal init fish | source

      This creates x() and xctl() shell functions.
      Customize with: eval "$(portal init zsh --cmd p)"
    EOS
  end

  test do
    assert_match "portal", shell_output("#{bin}/portal version")
  end
end
