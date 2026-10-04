class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
      sha256 "cf436ac2b521346ea3a6e6291797daec6de42f3543b91d1506fa5c9d4be93fe9"
    elsif Hardware::CPU.intel?
      url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
      sha256 "b36de4f0c4b232dc3db12477420d9feef21001cc757a7114fec4780253f15b41"
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
