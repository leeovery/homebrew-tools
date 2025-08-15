class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  version "0.0.8"
  
  # No URL needed - we'll clone directly in install method
  
  depends_on "gh"
  
  depends_on "git"

  def install
    # Clone the repository using gh CLI (handles private repo authentication)
    system "gh", "repo", "clone", "leeovery/stitch", ".", "--", "--branch", "v#{version}"
    
    # Install the files
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