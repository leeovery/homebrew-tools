class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.7.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "cc5733f40db4aae659e9ecc06dd1db7e0493f58eba4677bdaa80918a03c225ba"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "a469cb37f540c27f8755fdba4cd67c6d6fedd53cdecdc5c480cf1632d3e4586d"
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
