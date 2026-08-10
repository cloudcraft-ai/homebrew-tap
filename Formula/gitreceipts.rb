class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.4"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.4/git-receipts-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "8f974e9dd3cdc10e79241b90719eb7954511f1d4524a66c18ea3c4324aa78a93"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.4/git-receipts-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "c77ae27a8ebe29efc85bb5c548e8997b6eb29dc8005abedb55462ebcab856174"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.4/git-receipts-v0.1.4-x86_64-unknown-linux-musl.tar.gz"
    sha256 "af514bd608d0ddb609a604d4eb4fd1c520c03f1a140cdb7ff1bfff136289f1ab"
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
