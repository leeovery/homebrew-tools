class Portal < Formula
  desc "Interactive session picker for zmx"
  homepage "https://github.com/leeovery/portal"
  version "1.0.2"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "fd65029b37b76b8fd161a81203b53f023b221c5fc25b10e9f4d5c93840fbb5a1"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "3311308fd58dbc69a5a19a6649c0daba2c989d10b71c4b07733505bb8cb84262"
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
