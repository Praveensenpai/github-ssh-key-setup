# Maintainer: Praveen <praveen@local>
pkgname=github-ssh-key-setup-git
pkgver=1.0.0
pkgrel=1
pkgdesc="Automated Ed25519 SSH key generator and GitHub connection setup utility"
arch=('any')
url="https://github.com/Praveensenpai/github-ssh-key-setup"
license=('MIT')
depends=('bash' 'openssh' 'curl')
makedepends=('git')
provides=('github-ssh-key-setup')
conflicts=('github-ssh-key-setup')
source=("git+https://github.com/Praveensenpai/github-ssh-key-setup.git")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}" 2>/dev/null || cd "$srcdir"
  git describe --long --tags 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' || echo "1.0.0"
}

package() {
  cd "$srcdir/${pkgname%-git}" 2>/dev/null || cd "$srcdir"
  install -Dm755 bin/github-ssh-key-setup "$pkgdir/usr/bin/github-ssh-key-setup"
}
