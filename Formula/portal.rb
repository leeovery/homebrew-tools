class Portal < Formula
  desc "Interactive session picker for zmx"
  homepage "https://github.com/leeovery/portal"
  version "1.1.0"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "9ff534ed3d6a4cd69debdb23947b555d68f4d6b1b801bc84137a02b355f73bcc"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "27d987a23c8dc27ccf28a19f8c20db3b721fc2ab64af9ffb0cf6c2446a6aba96"
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
