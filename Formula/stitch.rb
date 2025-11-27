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
      "1.2.31" => "321551861",
      "1.2.30" => "321544084",
      "1.2.29" => "321508409",
      "1.2.28" => "321505547",
      "1.2.27" => "321504510",
      "1.2.26" => "321463258",
      "1.2.25" => "321463139",
      "1.2.24" => "321461244",
      "1.2.23" => "321452029",
      "1.2.22" => "321084264",
      "1.2.21" => "320687252",
      "1.2.20" => "320607942",
      "1.2.19" => "320329414",
      "1.2.18" => "320302390",
      "1.2.17" => "320287140",
      "1.2.16" => "320263468",
      "1.2.15" => "320248529",
      "1.2.14" => "320239412",
      "1.2.13" => "320234702",
      "1.2.12" => "320224405",
      "1.2.11" => "319304338",
      "1.2.10" => "319243104",
      "1.2.9" => "318873975",
      "1.2.8" => "318873313",
      "1.2.7" => "318873019",
      "1.2.6" => "318870393",
      "1.2.5" => "318868629",
      "1.2.4" => "318859491",
      "1.2.3" => "318825050",
      "1.2.2" => "318822741",
      "1.2.1" => "318755054",
      "1.2.0" => "318425650",
      "1.1.12" => "318424638",
      "1.1.11" => "316477984",
      "1.1.10" => "316025651",
      "1.1.9" => "315061483",
      "1.1.8" => "313813426",
      "1.1.7" => "313787432",
      "1.1.6" => "313753816",
      "1.1.5" => "313741756",
      "1.1.4" => "313366218",
      "1.1.3" => "312447488",
      "1.1.2" => "311575992",
      "1.1.1" => "311290245",
      "1.1.0" => "311289918",
      "1.0.5" => "311285078",
      "1.0.4" => "311273058",
      "1.0.3" => "311028474",
      "1.0.2" => "310944941",
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
  url "https://github.com/leeovery/stitch/releases/download/v1.2.31/stitch-v1.2.31.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "ceb4230f6bb8294267b1e2f2369209e6947f33471749d73cb7bf6a279cdaefac"
  version "1.2.31"

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
        stitch init

      Optional dependencies for full functionality:

        brew install claude      # Claude AI for release notes

      For more information:
        stitch help
    ---------------------------------------------------------
    EOS
  end

  test do
    system "#{bin}/stitch", "--version"
  end
end
