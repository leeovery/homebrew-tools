class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.4.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "2eb7c5414387295672e8fead23902c7dcf9b243e644935bcc6436ec9e5d35bbf"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "100b9ed518edae57041ed32267679826298ed1711f3d8132c1c1f4cf65bb4c63"
  end

  def install
    bin.install "kit"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
