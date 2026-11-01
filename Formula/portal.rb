class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.12.4"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
    sha256 "452c7e6fc711533b382d929605e201fa0582f57ba49ce4e2be1793bb06546229"
  end
  on_intel do
    url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
    sha256 "e6eb8d756acd897fd97be500a009dd3286f91619cfdcb5a5119443322bc37562"
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
