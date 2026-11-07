class Mio < Formula
  desc "Programming language with native compilation (full)"
  homepage "https://github.com/mio-kobo/mio"
  url "https://github.com/mio-kobo/mio/releases/download/v2.1.0/mio-2.1.0-darwin-arm64-full.tar.gz"
  version "2.1.0"
  sha256 "a62e33955b5cc96c8fede84dd618146fee5ede6d10566e0022a610c0983203c6"
  license "MIT"
  depends_on arch: :arm64
  depends_on :macos
  conflicts_with "mio-core", because: "both provide the mio command"

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
    system bin/"mio", "check", "math.mio"
  end
end
