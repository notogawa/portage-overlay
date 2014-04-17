# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 eutils

DESCRIPTION="Universal Command Line Environment for AWS."
HOMEPAGE="https://github.com/aws/aws-cli https://pypi.python.org/pypi/awscli"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/botocore-0.40.0
		 <dev-python/botocore-0.41.0
		 >=dev-python/bcdoc-0.12.0
		 <dev-python/bcdoc-0.13.0
		 >=dev-python/six-1.1.0
		 =dev-python/colorama-0.2.5
		 >=dev-python/docutils-0.10
		 =dev-python/rsa-3.1.2
		 virtual/python-argparse"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}] )"

RESTRICT="test"

DOCS=( README.rst )

python_test() {
  nosetests || die "Tests fail with ${EPYTHON}"
}
