class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  version "0.0.8"
  
  url do
    require "homebrew/api"
    require "homebrew/github"
    
    # Use Homebrew's built-in GitHub credentials for private repo access
    headers = {
      "Authorization" => "bearer #{GitHub::API.credentials}",
      "Accept" => "application/vnd.github.v3+json"
    }
    
    release_data = GitHub.get_release("leeovery/stitch", "v#{version}")
    tarball_url = release_data["tarball_url"]
    
    # Return the authenticated tarball URL
    tarball_url
  end
  
  sha256 :no_check  # Skip SHA verification for dynamic URLs
  
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