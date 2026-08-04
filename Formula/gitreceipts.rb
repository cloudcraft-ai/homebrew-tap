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
      sha256 "7a4f4e9cdae8246786d927d22539b4464507d8b0012ba8ea6363b71aaf1250c4"
    else
      url "https://github.com/cloudcraft-ai/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0d9fb8dcdb73bf8bc7f2aed56d13018a19401c29ab0a1b1892b37cd76b692cae"
    end
  end
  on_linux do
    url "https://github.com/cloudcraft-ai/gitreceipts/releases/download/v0.1.0/git-receipts-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "b825c1366d595cdbc6a1984c707ce80afa3d6e315128d47870eed2dbd24839a6"
  end

  def install
    bin.install "git-receipts"
  end

  test do
    assert_match "git-receipts", shell_output("#{bin}/git-receipts --version")
  end
end
