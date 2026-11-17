class Kit < Formula
  desc "Set up a Mac from a config repository, and keep it that way"
  homepage "https://github.com/leeovery/kit"
  version "0.1.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_arm64.tar.gz"
    sha256 "95c3b443c07d42d6612fad924fc98e2146fe181ae4c9aa8a3f4a3dcd08bbd8c2"
  end
  on_intel do
    url "https://github.com/leeovery/kit/releases/download/v#{version}/kit_#{version}_darwin_amd64.tar.gz"
    sha256 "ea99ac34d09cd2af5cc52d18c5d6d798e116f7d6195825aa3a509a4e9fc1c8cf"
  end

  def install
    bin.install "kit"
  end

  test do
    assert_match "kit version", shell_output("#{bin}/kit --version")
  end
end
