class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.6.1"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "76f6f15ead97d442c8da5dbc7774ec72ebbad272024e7c62132823361629aa45"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "0f75fc6091e1c91740cc5edbdb1105c0e30807f486c98b6ce95497d0f5021ad0"
  end

  def install
    bin.install "kit"
    libexec.install "kit.app"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
