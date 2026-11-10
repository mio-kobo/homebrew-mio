class Mio < Formula
  desc "Programming language with native compilation (full)"
  homepage "https://github.com/mio-kobo/mio"
  url "https://github.com/mio-kobo/mio/releases/download/v2.1.2/mio-2.1.2-darwin-arm64-full.tar.gz"
  version "2.1.2"
  sha256 "5bd450ab96e6da945e5baa97d9ddd31162a289e183ffe3eff6635d3006344c8d"
  license "MIT"
  depends_on arch: :arm64
  depends_on :macos
  conflicts_with "mio-core", because: "both provide the mio command"

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
    system bin/"mio", "check", "math.mio"
  end
end
