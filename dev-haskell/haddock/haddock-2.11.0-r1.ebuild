# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit eutils haskell-cabal pax-utils

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
# ia64 lost as we don't have ghc-7 there yet
# ppc64 needs to be rekeyworded due to xhtml not being keyworded
KEYWORDS="~alpha ~amd64 -ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-haskell/ghc-paths[profile?]
		=dev-haskell/xhtml-3000.2*[profile?]
		>=dev-lang/ghc-7.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.14"

RESTRICT="test" # avoid depends on QC

CABAL_EXTRA_BUILD_FLAGS="--ghc-options=-rtsopts"

src_prepare() {
	# we would like to avoid happy and alex depends
	epatch "${FILESDIR}"/${PN}-2.10.0-drop-tools.patch
}

src_configure() {
	# create a fake haddock executable. it'll set the right version to cabal
	# configure, but will eventually get overwritten in src_compile by
	# the real executable.
	local exe="${S}/dist/build/haddock/haddock"
	mkdir -p $(dirname "${exe}")
	echo -e "#!/bin/sh\necho Haddock version ${PV}" > "${exe}"
	chmod +x "${exe}"

	haskell-cabal_src_configure --with-haddock="${exe}" --constraint='Cabal ==1.14.*'
}

src_compile() {
	# when building the (recursive..) haddock docs, change the datadir to the
	# current directory, as we're using haddock inplace even if it's built to be
	# installed into the system first.
	haddock_datadir="${S}" haskell-cabal_src_compile
}

src_install() {
	cabal_src_install
	# haddock uses GHC-api to process TH source.
	# TH requires GHCi which needs mmap('rwx') (bug #299709)
	pax-mark -m "${D}/usr/bin/${PN}"
}
