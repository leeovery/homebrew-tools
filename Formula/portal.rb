class Portal < Formula
  desc "Interactive session picker for zmx"
  homepage "https://github.com/leeovery/portal"
  version "1.0.0"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "f93844554270005dd813b230b818da34438386c4440acb5e1b106dc8faddb7ae"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "ec6e0796f8bbb10ee8e85b34bda80ef1504e14101d7b2d623e1b316976301ba9"
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
