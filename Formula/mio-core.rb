class MioCore < Formula
  desc "Programming language with native compilation (core)"
  homepage "https://github.com/mio-kobo/mio"
  url "https://github.com/mio-kobo/mio/releases/download/v2.1.2/mio-2.1.2-darwin-arm64-core.tar.gz"
  version "2.1.2"
  sha256 "8fecf123504f03bbc095427201bcf2f3badaea9bafbcdf4a25ea5c1b454552c7"
  license "MIT"
  depends_on arch: :arm64
  depends_on :macos
  conflicts_with "mio", because: "both provide the mio command"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/mio"
  end

  test do
    assert_match "2.1.2", shell_output("#{bin}/mio version")
    (testpath/"hello.mio").write 'chant("hello from Mio");'
    system bin/"mio", "build", "hello.mio", "--target=darwin-arm64", "-o", "hello"
    assert_equal "hello from Mio\n", shell_output("./hello")
    (testpath/"math.mio").write 'yobu "kiso/math"; chant(math.abs(-9));'
    assert_match "E_BUNKO_MISSING", shell_output("#{bin}/mio check math.mio 2>&1", 1)
  end
end
