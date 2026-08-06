class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.0"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "64e4a98af91aabd70dbd49e8489773dcab2dce1cf622f91fff839e0151484c1f"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "1edee63c08cbb58cde60432a2952d6d1d67af0af5297c76c4bf423931ea9755f"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "56675646f7b95f0a6d8b04671e7ba25559b5128e588a943ddaafcddc174ac3bb"
  end

  def install
    bin.install "git-receipts"
    # The package is `gitreceipts`; the binary is `git-receipts` (so git picks
    # it up as `git receipts`). Alias the package name too, so both work.
    bin.install_symlink "git-receipts" => "gitreceipts"
  end

  test do
    assert_match "git-receipts", shell_output("#{bin}/git-receipts --version")
  end
end
