# Downloads a release asset of a private repository through GitHub's API, with
# HOMEBREW_GITHUB_API_TOKEN. It finds the asset by its file name in the release
# the URL names, so no asset id is kept here. It hands the token to curl on
# stdin, never in a command line, and runs curl with --disable, so no
# ~/.curlrc applies. A failure is raised as a download's, never ended with
# odie, which Homebrew's download threads would swallow.
class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  RELEASE_URL = %r{\Ahttps://github\.com/([^/]+/[^/]+)/releases/download/([^/]+)/([^/]+)\z}
  ASSET_URL = %r{\Ahttps://api\.github\.com/repos/[^/]+/[^/]+/releases/assets/\d+\z}

  def _fetch(url:, resolved_url:, timeout:)
    repo, tag, name = url.match(RELEASE_URL)&.captures
    raise CurlDownloadStrategyError.new(url, "it isn't a GitHub release download") unless repo

    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")
    if token.empty?
      raise CurlDownloadStrategyError.new(url,
                                          "#{repo} is private: set HOMEBREW_GITHUB_API_TOKEN " \
                                          "to a token that can read it")
    end

    asset = asset_url(url, repo, tag, name, token, timeout)
    curl_with(token, timeout, "--location", "--remote-time", "--output", temporary_path,
              "--header", "Accept: application/octet-stream", asset)
  end

  private

  def asset_url(url, repo, tag, name, token, timeout)
    release = begin
      curl_with(token, timeout, "--header", "Accept: application/vnd.github+json",
                "https://api.github.com/repos/#{repo}/releases/tags/#{tag}").stdout
    rescue ErrorDuringExecution => e
      raise CurlDownloadStrategyError.new(url,
                                          "can't read #{repo}'s release #{tag}: the token can't see the repo, " \
                                          "or there's no such release\n#{e.stderr}")
    end
    asset = JSON.parse(release).fetch("assets", []).find { |a| a["name"] == name }
    raise CurlDownloadStrategyError.new(url, "#{repo}'s release #{tag} has no #{name}") unless asset
    unless asset["url"].to_s.match?(ASSET_URL)
      raise CurlDownloadStrategyError.new(url, "GitHub gave #{name} an unexpected URL: #{asset["url"]}")
    end

    asset["url"]
  end

  def curl_with(token, timeout, *args)
    system_command!(
      "curl",
      args:         ["--disable", "--silent", "--show-error", "--fail", "--retry", "3", "--header", "@-", *args],
      input:        "Authorization: Bearer #{token}\n",
      print_stderr: false,
      secrets:      [token],
      timeout:,
    )
  end
end

class Stitch < Formula
  desc "Shipping tool for you and your agents"
  homepage "https://github.com/leeovery/stitch"
  version "0.1.1"
  version_scheme 1
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/stitch/releases/download/v#{version}/stitch_#{version}_darwin_arm64.tar.gz",
        using: GitHubPrivateReleaseDownloadStrategy
    sha256 "e992f2f33f59978909815040eb831009d4710e7f01592ce735a1550eaaa49d38"
  end
  on_intel do
    url "https://github.com/leeovery/stitch/releases/download/v#{version}/stitch_#{version}_darwin_amd64.tar.gz",
        using: GitHubPrivateReleaseDownloadStrategy
    sha256 "1b0d84c1bca928076f6550d2042a402ff993bba63130f4abbbf9f988d114da2d"
  end

  def install
    bin.install "stitch"
  end


  test do
    assert_match version.to_s, shell_output("#{bin}/stitch --version")
  end
end
