# Sends the token only as it downloads, so it never shows in the cask's url
# specs (brew info --json); Homebrew drops it itself once GitHub redirects to
# the asset's storage. Where GitHub would answer a missing, wrong or expired
# token with a bare 401 or 404, it says what the download needs. A zip
# already in the cache, as at a reinstall, needs no token.
class GitHubTokenDownloadStrategy < CurlDownloadStrategy
  TOKEN_NEEDED = "SitRep downloads from a private repository: set HOMEBREW_GITHUB_API_TOKEN " \
                 "to a GitHub token that can read leeovery/sitrep (a classic token's repo scope, " \
                 "or a fine-grained one's read access to its contents).".freeze

  def fetch(timeout: nil)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")
    if token.empty?
      return super if cached_location.exist?

      raise CurlDownloadStrategyError.new(url, TOKEN_NEEDED)
    end

    meta[:headers] = [
      *meta[:headers]&.reject { |header| header.start_with?("Authorization") },
      "Authorization: Bearer #{token}",
    ]
    begin
      super
    rescue CurlDownloadStrategyError => e
      raise unless e.message.match?(/error: 40[134]\b/)

      raise e.exception("#{e.message}\n#{TOKEN_NEEDED}")
    end
  end
end

cask "sitrep" do
  asset_id = "0"
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  # The release asset through GitHub's API, the only way to download it from a
  # private repository. Its id is new at every upload, so it pins the release
  # as a version in the url would.
  url "https://api.github.com/repos/leeovery/sitrep/releases/assets/#{asset_id}",
      using:  GitHubTokenDownloadStrategy,
      header: "Accept: application/octet-stream"
  name "SitRep"
  desc "Board for Claude Code sessions in the menu bar"
  homepage "https://github.com/leeovery/sitrep"

  livecheck do
    skip "Private repository: the update-formula workflow updates it"
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "SitRep.app"

  uninstall quit: [
    "com.leeovery.sitrep",
    "com.leeovery.sitrep.notices",
  ]

  # Never ~/.local/state/sitrep: that is the board itself, not the app's. Nor
  # ~/Library/Logs/SitRep, which only app/release writes, on a Mac that
  # releases: its logs keep what resending the cask needs.
  zap trash: [
    "~/Library/Application Support/sitrep",
    "~/Library/Caches/com.leeovery.sitrep",
    "~/Library/HTTPStorages/com.leeovery.sitrep",
    "~/Library/Preferences/com.leeovery.sitrep.plist",
    "~/Library/Saved Application State/com.leeovery.sitrep.savedState",
  ]
end
