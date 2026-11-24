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

  def caveats
    <<~EOS
      The bash Stitch runs as stitch-bash, for the apps still on the old
      platform; its messages still say stitch. stitch is the Go Stitch:
        brew install leeovery/tools/stitch
    EOS
  end

  test do
    system bin/"stitch-bash", "--version"
  end
end
