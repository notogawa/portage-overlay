# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit waf-utils eutils

DESCRIPTION="a lightweight and small benchmarking tool for webservers."
HOMEPAGE="http://redmine.lighttpd.net/projects/weighttp"
SRC_URI="http://git.lighttpd.net/weighttp.git/snapshot/weighttp-master.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libev"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	mv weighttp-master "${S}"
}

src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS-VARIABLE: WAF_BINARY
	# @DESCRIPTION:
	# Eclass can use different waf executable. Usually it is located in "${S}/waf".
	: ${WAF_BINARY:="${S}/waf"}

	tc-export AR CC CPP CXX RANLIB
	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" \"${WAF_BINARY}\" --prefix=${EPREFIX}/usr $@ configure"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" \
		"$@" \
		configure || die "configure failed"
}
