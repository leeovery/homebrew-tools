cask "spaceman" do
  version "2.1.0"
  sha256 "4928fbf2f93cc2cc719649813c5dd30d6402931765971fb53e0c775e22264fcf"

  # The zip press upload uploads, named by [package] name in spaceman's
  # .press.toml.
  url "https://github.com/leeovery/spaceman/releases/download/v#{version}/Spaceman-#{version}.zip"
  name "Spaceman"
  desc "Spaces in the menu bar, named in Mission Control"
  homepage "https://github.com/leeovery/spaceman"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Spaceman.app"

  uninstall quit: "com.leeovery.Spaceman"

  zap trash: [
    "~/Library/Caches/com.leeovery.Spaceman",
    "~/Library/HTTPStorages/com.leeovery.Spaceman",
    "~/Library/Preferences/com.leeovery.Spaceman.plist",
    "~/Library/Saved Application State/com.leeovery.Spaceman.savedState",
  ]
end
