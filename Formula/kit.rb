class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.4.1"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "c50633d7c98cd7b98b3dda32cd56f15d0a0df43cde6aa3df4df92a89d9b06383"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "454e4e779523ddaac9f85427a81305f954bc59e27e85f9ce3bd7f06dc88c2b4c"
  end

  def install
    bin.install "kit"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
