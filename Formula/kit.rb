class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "2ce38e7dbc31b0f6cc7a36c509657dc4a69f6987d12238fad6c8ce3cfcbb6fcb"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "fe54174e64606736c700fc07ff238ff23425d9fa60284bf5d93979afa0ec8e63"
  end

  def install
    bin.install "kit"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
