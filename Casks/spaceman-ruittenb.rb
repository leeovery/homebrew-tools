cask "spaceman-ruittenb" do
  version "1.27.0"
  sha256 "d532c15b3923b7070b7f0936e998e6f740354e0664b95bf972875ffd82fe7e71"

  url "https://github.com/ruittenb/Spaceman/releases/download/v#{version}/Spaceman-#{version}.dmg"
  name "Spaceman"
  desc "View Spaces / Virtual Desktops in the menu bar"
  homepage "https://github.com/ruittenb/Spaceman"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "spaceman"
  depends_on macos: :ventura

  app "Spaceman.app"

  uninstall quit: "dev.ruittenb.Spaceman"

  zap trash: [
    "~/Library/Caches/dev.ruittenb.Spaceman",
    "~/Library/HTTPStorages/dev.ruittenb.Spaceman",
    "~/Library/Preferences/dev.ruittenb.Spaceman.plist",
    "~/Library/WebKit/dev.ruittenb.Spaceman",
  ]
end
