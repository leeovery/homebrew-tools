class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://api.github.com/repos/leeovery/stitch/tarball/v0.0.8"
  sha256 "96fb2fba25bc8cc7e29d4d56d485b1f5e82594aea51c122aa2d5f13b5ada9daa"
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