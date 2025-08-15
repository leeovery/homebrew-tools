class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    # For release assets, we need to use the GitHub API with proper headers
    if ENV["HOMEBREW_GITHUB_API_TOKEN"] && url.include?("/releases/download/")
      # Convert release download URL to API URL
      asset_url = url.gsub(%r{github\.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(.+)}, 
                          'api.github.com/repos/\1/\2/releases/tags/\3')
      
      # Get the asset ID from the release
      release_response = `curl -s -H "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}" "#{asset_url}"`
      require "json"
      release_data = JSON.parse(release_response)
      
      asset_filename = File.basename(url)
      asset = release_data["assets"]&.find { |a| a["name"] == asset_filename }
      
      if asset
        # Download via API with proper headers
        curl_args = ["--location", "--remote-time", "--output", temporary_path]
        curl_args += ["--header", "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"]
        curl_args += ["--header", "Accept: application/octet-stream"]
        curl_args << asset["url"]
        
        system_command!("curl", args: curl_args, env: { "HOMEBREW_CURL_RETRIES" => "3" })
        return
      end
    end
    
    # Fallback to regular download
    super
  end
end

class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://github.com/leeovery/stitch/releases/download/v0.0.9/stitch-v0.0.9.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "a8ac7d160aa7626fed7937ad7a5aca9de851767720063907d3eba9be0d0d4693"
  version "0.0.9"

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
