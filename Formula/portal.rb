class Portal < Formula
  desc "Interactive session picker for zmx"
  homepage "https://github.com/leeovery/portal"
  version "1.1.2"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "cc1ef5a1c7a987c169ed93013470290017a748ffca94dc5546868cbdfb6c98e1"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "d0394e2173072cd291c696d26bab9d193f3c5c5094e32dd16616b5f7fa55201d"
  end

  def install
    bin.install "portal"
  end

  def caveats
    <<~EOS
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
