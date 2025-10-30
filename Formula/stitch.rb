class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    if ENV["HOMEBREW_GITHUB_API_TOKEN"] && url.include?("/releases/download/")
      # Convert GitHub release download URL to API asset URL
      asset_id = get_asset_id(url)
      if asset_id
        api_url = "https://api.github.com/repos/leeovery/stitch/releases/assets/#{asset_id}"
        curl_args = ["--location", "--remote-time", "--output", temporary_path]
        curl_args += ["--header", "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"]
        curl_args += ["--header", "Accept: application/octet-stream"]
        curl_args << api_url

        system_command!("curl", args: curl_args, env: { "HOMEBREW_CURL_RETRIES" => "3" })
        return
      end
    end

    # Fallback to regular download
    super
  end

  private

  def get_asset_id(url)
    # Extract version from URL
    version_match = url.match(/\/v(\d+\.\d+\.\d+)\//)
    return nil unless version_match

    version = version_match[1]

    # Map versions to asset IDs (updated by automation)
    asset_ids = {
      "1.0.1" => "310520870",
      "1.0.0" => "310517125",
      "0.0.14" => "282841990",
      "0.0.13" => "282841922",
      "0.0.12" => "282841777",
      "0.0.11" => "282839271",
      "0.0.10" => "282838303",
      "0.0.9" => "282831274"
    }

    asset_ids[version]
  end
end

class Stitch < Formula
  desc "Release management CLI for coordinated feature releases"
  homepage "https://github.com/leeovery/stitch"
  url "https://github.com/leeovery/stitch/releases/download/v1.0.1/stitch-v1.0.1.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "89632b3892c7a1a6a328cce23f3cc34f8dd8b10bfdd1c40a0389b9574532ee84"
  version "1.0.1"

  depends_on "git"
  depends_on "bash-toolkit"

  def install
    bin.install "bin/stitch"
    lib.install Dir["lib/*"]
    share.install "templates"
  end

  def caveats
    <<~EOS
    ---------------------------------------------------------
      Stitch has been installed!

      To get started:
        cd your-project
        stitch init --type=laravel

      Optional dependencies for full functionality:

        brew install gh          # GitHub CLI for build status
        brew install claude      # Claude AI for release notes

      For more information:
        stitch --help
    ---------------------------------------------------------
    EOS
  end

  test do
    system "#{bin}/stitch", "--version"
  end
end
