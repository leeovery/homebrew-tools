class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.1.1"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "713b003c59c20b2d570731fcc908c98fbe125f408780a5dd4490275bb25a0674"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "666159bb45bfad136316ee25a63092091f69b6a74e076fd2a80d4f4598b7c380"
  end

  def install
    bin.install "kit"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
