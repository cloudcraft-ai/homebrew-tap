class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.2"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.2/git-receipts-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "f696b4628884653efc3a314b09a74777fdf696388c1411cd247a2e08ae2e3a81"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.2/git-receipts-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "fd3ea963fc97ee15474539be36762b28f09707707b38e944a4434b84c1edbcb6"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.2/git-receipts-v0.1.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "351ab853619c9804237409a3fad26f850d0fbf746104e5c604abfcb191f17084"
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
