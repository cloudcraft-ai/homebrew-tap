cask "clipbob" do
  version "0.3.6"
  sha256 "dc109433dc7f41ca73b2e62beea1742a591c14f268c718b83a0ef7a80d3b1ca2"

  url "https://clipbob.app/ClipBob-#{version}.dmg"
  name "ClipBob"
  desc "Clipboard history that syncs across all your Macs"
  homepage "https://clipbob.app/"

  livecheck do
    url "https://clipbob.app/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "ClipBob.app"

  zap trash: [
    "~/Library/Application Support/Clipbob",
    "~/Library/Caches/ai.cloud-craft.clipbob",
    "~/Library/Caches/Clipbob",
    "~/Library/HTTPStorages/ai.cloud-craft.clipbob",
    "~/Library/HTTPStorages/ai.cloud-craft.clipbob.binarycookies",
    "~/Library/Preferences/ai.cloud-craft.clipbob.plist",
  ]
end
