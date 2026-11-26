class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.5.4"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "6f837f6cbb856696f77135d52246ab3505ea9808ff2f99d616490b67ced47614"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "c4ee8bee864514f52dbab916eed302c90cef0c103c0ed713ec35959075efe062"
  end

  def install
    bin.install "kit"
    libexec.install "kit.app"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
