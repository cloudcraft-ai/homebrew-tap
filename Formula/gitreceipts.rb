class Gitreceipts < Formula
  desc "See what your agent actually did - reconcile a coding-agent session against git"
  homepage "https://github.com/cloudcraft-ai/gitreceipts"
  version "0.1.0"
  license "MIT"

  # Verified on macOS (Apple Silicon) and Linux (x86_64). The Intel macOS
  # binary passes the full test suite as x86_64 code (Rosetta 2 translation
  # in CI), but is not hand-verified on Intel silicon.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cloudcraft-ai/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "da200c54103ddce7d3f31f8943a2f0ff3d2a53889e3ef599909c2fbe89d3db95"
    else
      url "https://github.com/cloudcraft-ai/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "6d9d45d59f81981384353eda1595c0360da176e88da2102fcaa41c70498972bf"
    end
  end
  on_linux do
    url "https://github.com/cloudcraft-ai/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "a4426fb67aecb493af0e11e6507dcbe9eb53ff225615b256fdbf0ced72d73dee"
  end

  def install
    bin.install "git-receipts"
  end

  test do
    assert_match "git-receipts", shell_output("#{bin}/git-receipts --version")
  end
end
