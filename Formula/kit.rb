class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.6.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "9ed76cb1fcd68420f7248640b78323062a9393f9febdd12f152d36e12c4c826d"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "0b5f58cf3b909e49b7f5871d319199f1e9bdf0e1b0c2081d4f2d0f0449d07908"
  end

  def install
    bin.install "kit"
    libexec.install "kit.app"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
