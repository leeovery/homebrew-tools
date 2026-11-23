class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.5.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "ce93dd06b8f8b8b4aa322ff96c625fa2ac2af6bc42bdf52e4f1f46d4405ac49b"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "7646674cbee1e2287e375e818fa454f19aa88fd506656341d2f8f9ad492c7fb9"
  end

  def install
    bin.install "kit"
    libexec.install "kit.app"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
