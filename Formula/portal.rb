class Portal < Formula
  desc "Interactive session picker for tmux and Zellij"
  homepage "https://github.com/leeovery/portal"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_arm64.tar.gz"
      sha256 "9ff82d35e6507243c8b658d741d093bea691f118ee8cee9a3a3526788e596ba1"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/portal/releases/download/v#{version}/portal_#{version}_darwin_amd64.tar.gz"
      sha256 "27d3ef3da37a3b7fe4cebec1720b13b2d14e927f09c1f7dd0be90556d57bac24"
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
