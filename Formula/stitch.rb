class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    curl_args = ["--location", "--remote-time", "--output", temporary_path]
    
    if ENV["HOMEBREW_GITHUB_API_TOKEN"]
      curl_args += ["--header", "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"]
    end
    
    system_command!("curl", args: curl_args << url, env: { "HOMEBREW_CURL_RETRIES" => "3" })
  end
end

class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://github.com/leeovery/stitch/releases/download/v0.0.9/stitch-v0.0.9.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
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
