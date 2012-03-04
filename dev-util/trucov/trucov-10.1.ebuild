# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base cmake-utils

DESCRIPTION="Display the control flow of a program and its test coverage information."
HOMEPAGE="http://code.google.com/p/trucov/"
SRC_URI="http://trucov.googlecode.com/files/trucov_${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="nodot"

DEPEND=">=dev-libs/boost-1.46"
RDEPEND="${DEPEND}
		 !nodot? ( media-gfx/graphviz )"

RESTRICT="mirror"

S="${WORKDIR}/trucov_${PV}"

src_prepare() {
  epatch "${FILESDIR}"/boost_filesystem_v3.patch
}
