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

class StitchBash < Formula
  desc "Bash Stitch, for the apps still on the old platform"
  homepage "https://github.com/leeovery/stitch-bash"
  url "https://github.com/leeovery/stitch-bash/releases/download/v1.6.6/stitch-v1.6.6.tar.gz",
      using: GitHubPrivateReleaseDownloadStrategy
  sha256 "03b28de7b4db1c9af77132b8f4b6e243f8ca8f3e58e3b572984f30fbc0e0d262"

  depends_on "bash-toolkit"
  depends_on "git"

  # Its script finds its library and templates beside itself, so all of it
  # stays in libexec, run through a wrapper named stitch-bash: stitch is the
  # Go Stitch's command. The archive keeps no mode on the script, which only
  # bin's files are given, so it is made executable here.
  def install
    libexec.install "bin", "lib"
    (libexec/"share").install "templates"
    (libexec/"bin/stitch").chmod 0755
    (bin/"stitch-bash").write <<~SH
      #!/bin/bash
      exec "#{libexec}/bin/stitch" "$@"
    SH
    (bin/"stitch-bash").chmod 0755
  end


  test do
    system bin/"stitch-bash", "--version"
  end
end
