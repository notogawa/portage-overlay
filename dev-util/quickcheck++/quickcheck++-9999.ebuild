# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git

DESCRIPTION="A tool for testing C++ programs automatically."
HOMEPAGE="http://software.legiasoft.com/quickcheck/"
SRC_URI=""

EGIT_REPO_URI="http://software.legiasoft.com/git/quickcheck.git"
PATCHES=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="mirror"

S="${WORKDIR}/quickcheck_${PV}"

src_unpack() {
  git_src_unpack
}

src_install() {
  insinto /usr/include/quickcheck || die
  doins quickcheck/*.hh || die
  dodoc README COPYRIGHT ChangeLog || die
}
