class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.1"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.1/git-receipts-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "46a357a5913b77364a3f92c3a172d471148a02c8a104218b1443d7b81a0ffe09"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.1/git-receipts-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a21047eb754232155597533fa743b4be3e7c3e594051172356a8d0f657058505"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.1/git-receipts-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "5ad251ec4d276603496483cdc240031c457335fa871180af45f7c37b2568b8d0"
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
