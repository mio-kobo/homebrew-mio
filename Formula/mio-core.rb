class MioCore < Formula
  desc "Programming language with native compilation (core)"
  homepage "https://github.com/mio-kobo/mio"
  url "https://github.com/mio-kobo/mio/releases/download/v2.1.0/mio-2.1.0-darwin-arm64-core.tar.gz"
  version "2.1.0"
  sha256 "b31da6889c97c2751a895ad945bf655f061912a6c763c9f3320e37c55ba94910"
  license "MIT"
  depends_on arch: :arm64
  depends_on :macos
  conflicts_with "mio", because: "both provide the mio command"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/mio"
  end

  test do
    assert_match "2.1.0", shell_output("#{bin}/mio version")
    (testpath/"hello.mio").write 'chant("hello from Mio");'
    system bin/"mio", "build", "hello.mio", "--target=darwin-arm64", "-o", "hello"
    assert_equal "hello from Mio\n", shell_output("./hello")
    (testpath/"math.mio").write 'yobu "kiso/math"; chant(math.abs(-9));'
    assert_match "E_BUNKO_MISSING", shell_output("#{bin}/mio check math.mio 2>&1", 1)
  end
end
