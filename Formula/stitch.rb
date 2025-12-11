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
      "1.5.0" => "327439189",
      "1.4.8" => "326886668",
      "1.4.7" => "326474689",
      "1.4.6" => "326456793",
      "1.4.4" => "325993047",
      "1.4.3" => "325990572",
      "1.4.2" => "325904811",
      "1.4.1" => "325903270",
      "1.4.0" => "325901612",
      "1.3.13" => "324390682",
      "1.3.12" => "324385088",
      "1.3.11" => "324381552",
      "1.3.10" => "324378486",
      "1.3.9" => "324375807",
      "1.3.8" => "324374899",
      "1.3.7" => "324367272",
      "1.3.6" => "324359399",
      "1.3.5" => "324353160",
      "1.3.4" => "324351686",
      "1.3.3" => "324307241",
      "1.3.2" => "324251567",
      "1.3.1" => "323947431",
      "1.3.0" => "323947178",
      "1.2.39" => "322957972",
      "1.2.38" => "322939865",
      "1.2.37" => "321951521",
      "1.2.36" => "321946470",
      "1.2.35" => "321931809",
      "1.2.34" => "321923982",
      "1.2.33" => "321914939",
      "1.2.32" => "321554986",
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
  url "https://github.com/leeovery/stitch/releases/download/v1.5.0/stitch-v1.5.0.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "6347fc6637014ecd6971f5a9b6c6b45ab2c9e148f35207b56bfb3dc736d5a467"
  version "1.5.0"

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
