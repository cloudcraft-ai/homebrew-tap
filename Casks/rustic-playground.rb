cask "rustic-playground" do
  version "0.4.0"
  sha256 "72e749efff8d2cfe7ed6d0f9216d64304cbd22bb36eceb1a96da358086376dbd"

  url "https://github.com/jagmeetchawla/rustic-playground/releases/download/v#{version}/Rustic.Rust_#{version}_aarch64.dmg",
      verified: "github.com/jagmeetchawla/rustic-playground/"
  name "Rustic Playground"
  desc "macOS app for running Rust experiments, inspired by Swift Playgrounds"
  homepage "https://rustic-playground.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"
  depends_on arch: :arm64

  app "Rustic Rust.app"

  zap trash: [
    "~/Library/Application Support/com.rustic-playground.rust",
    "~/Library/Preferences/com.rustic-playground.rust.plist",
    "~/Library/Saved Application State/com.rustic-playground.rust.savedState",
  ]
end
