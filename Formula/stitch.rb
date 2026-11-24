# Downloads a release asset of a private repository through GitHub's API, with
# HOMEBREW_GITHUB_API_TOKEN. It finds the asset by its file name in the release
# the URL names, so no asset id is kept here, and it hands the token to curl on
# stdin, so it never shows in a command line.
class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  RELEASE_URL = %r{\Ahttps://github\.com/([^/]+/[^/]+)/releases/download/([^/]+)/([^/]+)\z}

  def _fetch(url:, resolved_url:, timeout:)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")
    repo, tag, name = url.match(RELEASE_URL)&.captures
    odie "#{url} isn't a GitHub release download" unless repo
    odie "#{repo} is private: set HOMEBREW_GITHUB_API_TOKEN to a token that can read it" if token.empty?

    auth = ["--header", "@-"]
    release = system_command!(
      "curl",
      args:         ["--silent", "--show-error", "--fail", "--location", *auth,
                     "--header", "Accept: application/vnd.github+json",
                     "https://api.github.com/repos/#{repo}/releases/tags/#{tag}"],
      input:        "Authorization: Bearer #{token}\n",
      print_stderr: false,
      secrets:      [token],
    ).stdout
    asset = JSON.parse(release).fetch("assets", []).find { |a| a["name"] == name }
    odie "#{repo}'s release #{tag} has no #{name}" unless asset

    system_command!(
      "curl",
      args:    ["--location", "--fail", "--remote-time", "--output", temporary_path, *auth,
                "--header", "Accept: application/octet-stream", asset["url"]],
      input:   "Authorization: Bearer #{token}\n",
      env:     { "HOMEBREW_CURL_RETRIES" => "3" },
      secrets: [token],
    )
  end
end

class Stitch < Formula
  desc "Shipping tool for you and your agents"
  homepage "https://github.com/leeovery/stitch"
  version "0.0.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/leeovery/stitch/releases/download/v#{version}/stitch_#{version}_darwin_arm64.tar.gz",
        using: GitHubPrivateReleaseDownloadStrategy
    sha256 "17332dba6e5365d5d27387883bc67317d677123df0c7ed2e1776efccd4e7e172"
  end
  on_intel do
    url "https://github.com/leeovery/stitch/releases/download/v#{version}/stitch_#{version}_darwin_amd64.tar.gz",
        using: GitHubPrivateReleaseDownloadStrategy
    sha256 "a24ae37604efeddec25809eecc2f9b62795a32bdc736ff6840686a6c31daeaed"
  end

  def install
    bin.install "stitch"
  end

  def caveats
    <<~EOS
      stitch is the Go Stitch, for apps on the new platform. The bash Stitch,
      for the apps still on the old one, is stitch-bash:
        brew install leeovery/tools/stitch-bash
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stitch --version")
  end
end
