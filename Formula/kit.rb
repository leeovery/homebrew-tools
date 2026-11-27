class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.5.6"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "510e8afe965ee0b18dbab1c060952c59e3256b49b99eee31740c8080a7214334"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "ba3531969edfc26faccb99e346196803ffdabef966b011bc671c11543d467494"
  end

  def install
    bin.install "kit"
    libexec.install "kit.app"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
