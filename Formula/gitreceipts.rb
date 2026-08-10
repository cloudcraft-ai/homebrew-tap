class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/jagmeetchawla/gitreceipts"
  version "0.1.3"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.3/git-receipts-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "5f207fb4880b3880a0d5186d77d7a98c3699043d3f4d632ea72abda138bec203"
    else
      url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.3/git-receipts-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "f74af866cb1339e8e797ace848aae10945d2f0513be7cd4999dd3bd4d30c4d48"
    end
  end
  on_linux do
    url "https://github.com/jagmeetchawla/gitreceipts/releases/download/v0.1.3/git-receipts-v0.1.3-x86_64-unknown-linux-musl.tar.gz"
    sha256 "232cf09ae4ff3e715e2e13154ec6192abf58aacf1f80b3e5a8a11e3768d02174"
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
