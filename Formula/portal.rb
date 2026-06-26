class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.8.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "6fe1655d54e873892b63396b761a35288870a255632735319c9ec4d6d9ba73e3"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "9222fc949d7997e66604c0a40cf3b0a0575a551cf79bef4b6f8dea5afce595a3"
    end
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
