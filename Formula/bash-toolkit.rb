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
      "0.0.1" => "284042477",
      "2.0.0" => "placeholder"
    }

    asset_ids[version]
  end
end

class BashToolkit < Formula
  desc "A modular bash library for terminal messaging, formatting, and user interaction"
  homepage "https://github.com/leeovery/bash-toolkit"
  url "https://github.com/leeovery/bash-toolkit/releases/download/v0.0.1/bash-toolkit-v0.0.1.tar.gz", using: GitHubPrivateRepositoryDownloadStrategy
  sha256 "41a65a125eb6ca5eb08b3fce0543c9fcd7e15ac406db43a1ec533f2729dd3d0c"
  version "0.0.1"

  def install
    bin.install "bin/bash-toolkit"
    lib.install Dir["lib/*"]
    share.install "examples"
  end

  def caveats
    <<~EOS
    ---------------------------------------------------------
      Bash Toolkit has been installed!

      To get started:
        source $(bash-toolkit common)
        message "Hello, World!" "success"

      Available modules:
        • common   - Core color and styling utilities
        • message  - Unified text output with semantic types
        • layout   - Layout functions with automatic indentation
        • prompt   - User interaction and input functions

      For more information:
        bash-toolkit --help
    ---------------------------------------------------------
    EOS
  end

  test do
    system "#{bin}/bash-toolkit", "--help"
  end
end