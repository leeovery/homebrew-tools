class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
      sha256 "06c4d27d3d812fcab94fadd61f8da949647122a764c112b248333010b184ec14"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
      sha256 "af9916bdf37443cf33f5992194247110d9fe4cdc8eb9cfe7130b0c1d9c3dfeb7"
    end
  end

  def install
    bin.install "kit"
  end

  def caveats
    <<~EOS
      kit reads your config repository from ~/.config/kit (or $KIT_CONFIG).
      Clone it there, then name this Mac, once, and see how it stands:

        kit machine <name>
        kit status
    EOS
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
