class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.5"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.5/git-receipts-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "a364535706a8546c193b81e710aa8557fd43892400c7a1b6f2453f93475bd536"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.5/git-receipts-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "52a471de62f8696e81162851910462cbe752a63b34945d221a18631fb3088b50"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.5/git-receipts-v0.1.5-x86_64-unknown-linux-musl.tar.gz"
    sha256 "6f185635228243e4edb3c8ce47e6d87031294e0d201c75d00a9967e532d294a9"
  end

  def install
    bin.install "git-receipts"
    # The package is `gitreceipts`; the binary is `git-receipts` (so git picks
    # it up as `git receipts`). Alias the package name too, so both work.
    bin.install_symlink "git-receipts" => "gitreceipts"
    # git intercepts `--help` for its subcommands and looks for a man page,
    # so `git receipts --help` only works if this is installed.
    man1.install Dir["man/*.1"]
  end

  test do
    assert_match "git-receipts", shell_output("#{bin}/git-receipts --version")
    assert_predicate man1/"git-receipts.1", :exist?
  end
end
