class GitHubPrivateDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    curl_args = ["--location", "--remote-time", "--output", temporary_path]
    
    # Add GitHub authentication
    if ENV["HOMEBREW_GITHUB_API_TOKEN"]
      curl_args += ["--header", "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"]
    end
    
    curl_args << resolved_url
    system_command!("curl", args: curl_args, env: { "HOMEBREW_CURL_RETRIES" => "3" })
  end
end

class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://api.github.com/repos/leeovery/stitch/tarball/v0.0.8", using: GitHubPrivateDownloadStrategy
  version "0.0.8"
  sha256 :no_check
  
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