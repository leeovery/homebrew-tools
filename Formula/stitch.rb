class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  version "0.0.8"
  
  depends_on "git"

  def install
    # Create a temporary directory
    temp_dir = Dir.mktmpdir
    
    # Use git to clone the repository directly (uses existing SSH/token auth)
    system "git", "clone", "https://github.com/leeovery/stitch.git", temp_dir
    system "git", "-C", temp_dir, "checkout", "v#{version}"
    
    # Install files from the cloned repository
    bin.install "#{temp_dir}/bin/stitch"
    lib.install Dir["#{temp_dir}/lib/*"]
    share.install "#{temp_dir}/templates"
    
    # Clean up
    FileUtils.rm_rf(temp_dir)
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