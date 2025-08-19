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
  url "https://github.com/leeovery/bash-toolkit/releases/download/v0.0.4/bash-toolkit-v0.0.4.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "b2529bad00e9995d9c989a1bd6c6c1653a33675298b0d1307fea04a43857802c"
  version "0.0.4"

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