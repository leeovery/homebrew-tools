class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    if ENV["HOMEBREW_GITHUB_API_TOKEN"] && url.include?("/releases/download/")
      # Convert GitHub release download URL to API asset URL
      asset_id = get_asset_id(url)
      if asset_id
        api_url = "https://api.github.com/repos/leeovery/bash-toolkit/releases/assets/#{asset_id}"
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
      "1.1.12" => "443718914",
      "1.1.11" => "354718437",
      "1.1.10" => "341384453",
      "1.1.9" => "337866027",
      "1.1.8" => "337446641",
      "1.1.7" => "337020654",
      "1.1.6" => "330716208",
      "1.1.5" => "330616639",
      "1.1.4" => "330292603",
      "1.1.3" => "328978571",
      "1.1.1" => "328880936",
      "1.1.0" => "327421524",
      "1.0.20" => "327395400",
      "1.0.19" => "326868811",
      "1.0.18" => "326849041",
      "1.0.17" => "326463311",
      "1.0.15" => "326456549",
      "1.0.14" => "326452053",
      "1.0.13" => "324361612",
      "1.0.12" => "324361447",
      "1.0.11" => "321853391",
      "1.0.10" => "321554621",
      "1.0.9" => "321551378",
      "1.0.8" => "319303880",
      "1.0.7" => "318859711",
      "1.0.6" => "317436851",
      "1.0.5" => "317433454",
      "1.0.4" => "313741147",
      "1.0.3" => "312447698",
      "1.0.2" => "311575871",
      "1.0.1" => "311290859",
      "0.0.28" => "306509448",
      "0.0.26" => "305559749",
      "0.0.25" => "302312495",
      "0.0.24" => "300211944",
      "0.0.23" => "300163989",
      "0.0.22" => "298947267",
      "0.0.21" => "298878248",
      "0.0.20" => "298564401",
      "0.0.18" => "296770763",
      "0.0.17" => "296434863",
      "0.0.16" => "296431767",
      "0.0.15" => "296368940",
      "0.0.14" => "296368469",
      "0.0.13" => "296350452",
      "0.0.12" => "296078457",
      "0.0.10" => "287123953",
      "0.0.9" => "286718241",
      "0.0.8" => "286413350",
      "0.0.7" => "286411441",
      "0.0.6" => "285490965",
      "0.0.5" => "285486910",
      "0.0.4" => "284070975",
      "0.0.3" => "284069676",
      "0.0.2" => "284068512",
      "0.0.1" => "284042477",
    }

    asset_ids[version]
  end
end

class BashToolkit < Formula
  desc "A modular bash library for terminal messaging, formatting, and user interaction"
  homepage "https://github.com/leeovery/bash-toolkit"
  url "https://github.com/leeovery/bash-toolkit/releases/download/v1.1.12/bash-toolkit-v1.1.12.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "715278495e9ced9924ca71c29b75bc837b5e76b68de5a1fa9ee277ae86581fca"
  version "1.1.12"

  def install
    # Install path helper binary
    bin.install "bin/bash-toolkit"
    
    # Install library modules
    lib.install Dir["lib/*"]
    
    # Install examples as documentation
    share.install "examples"
  end

  def caveats
    <<~EOS
    ---------------------------------------------------------
      Bash Toolkit has been installed!

      To get started, source the main library:
        source $(bash-toolkit)
        message "Hello, World!" "success"

      Or load individual modules:
        source $(bash-toolkit message)
        source $(bash-toolkit layout)
        source $(bash-toolkit prompt)
        source $(bash-toolkit execution)

      Direct paths also work:
        source #{lib}/bash-toolkit.sh

      View examples:
        ls #{share}/examples/
        #{share}/examples/message-demo.sh

      Documentation: #{share}/examples/
    ---------------------------------------------------------
    EOS
  end

  test do
    # Test that files exist
    assert_predicate bin/"bash-toolkit", :exist?
    assert_predicate lib/"bash-toolkit.sh", :exist?
    assert_predicate lib/"message.sh", :exist?
    assert_predicate share/"examples", :exist?
    
    # Test path helper works
    output = shell_output("#{bin}/bash-toolkit")
    assert_equal "#{lib}/bash-toolkit.sh\n", output
    
    # Test basic library loading
    system "/bin/bash", "-c", "source $(#{bin}/bash-toolkit) && declare -F message > /dev/null"
  end
end