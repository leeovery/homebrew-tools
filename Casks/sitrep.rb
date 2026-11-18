cask "sitrep" do
  version "0.8.0"
  sha256 "cf30b7462eb9e094131c931f24992bf1c976767e68622730e6d77c32b4c49784"

  # The zip app/release-upload uploads, named by release_asset in
  # app/release-common.
  url "https://github.com/leeovery/sitrep/releases/download/v#{version}/SitRep-#{version}.zip"
  name "SitRep"
  desc "Board for Claude Code sessions in the menu bar"
  homepage "https://github.com/leeovery/sitrep"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "SitRep.app"

  # An upgrade quits SitRep and its notices helper to swap the bundle, and
  # Homebrew opens again, once the upgrade is done, whichever of them it quit:
  # SitRep's start is what refreshes the plugin it carries, so the app and the
  # plugin never part. A reinstall or a first install starts nothing: open
  # SitRep then. No postflight starts it any more: Homebrew 7 deprecates the
  # block, and its postflight_steps run in a sandbox where open finds no
  # executable in the app (-10827, tried 28 Oct 2026 on Homebrew 7.0.11).
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
