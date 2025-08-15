class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://github.com/leeovery/stitch/releases/download/v0.0.8/stitch-v0.0.8.tar.gz"
  sha256 "8d637f06e2e108ff8e8ef8367c759874fe5ee49f1cdc4a34cd9033b340713274"
  version "0.0.8"
  
  depends_on "git"

  def install
    bin.install "bin/stitch"
    lib.install Dir["lib/*"]
    share.install "templates"
  end

  def caveats
    <<~EOS
      Stitch has been installed!
      
      To get started:
        cd your-project
        stitch init --type=laravel
        
      Optional dependencies for full functionality:
        brew install gh          # GitHub CLI for build status
        brew install claude      # Claude AI for release notes
        
      For more information:
        stitch --help
    EOS
  end

  test do
    system "#{bin}/stitch", "--version"
  end
end