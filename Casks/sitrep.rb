cask "sitrep" do
  version "0.9.0"
  sha256 "dcf62e166d0e1bda30c8e594a88f5aaf0d8ccdeb7d4205c633f04a1757ba393d"

  # The zip press upload uploads, named by [package] name in sitrep's
  # .press.toml.
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

  # The CLI the bundle carries for its plugin, linked into Homebrew's bin so
  # a login shell, in Ghostty or over SSH, finds sitrep: bare, it opens the
  # board in that terminal. It is a compiled binary, so it needs no Bun.
  binary "#{appdir}/SitRep.app/Contents/Resources/Plugin/bin/sitrep"

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
  # ~/Library/Logs/press, where press logs every project's releases on a Mac
  # that releases, sitrep's among them: its logs keep what resending the cask
  # needs. ~/Library/Logs/SitRep, where sitrep's release scripts logged before
  # press, nothing writes now.
  zap trash: [
    "~/Library/Application Support/sitrep",
    "~/Library/Caches/com.leeovery.sitrep",
    "~/Library/HTTPStorages/com.leeovery.sitrep",
    "~/Library/Preferences/com.leeovery.sitrep.plist",
    "~/Library/Saved Application State/com.leeovery.sitrep.savedState",
  ]
end
