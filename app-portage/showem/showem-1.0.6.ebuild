# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="View output of a parallel emerge from a separate terminal"
BASE_SERVER_URI="https://github.com/TheGreatMcPain"
HOMEPAGE="https://github.com/GenPi64/showem"
SRC_URI="https://github.com/GenPi64/showem/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-libs/ncurses-5.9-r2
	>=app-shells/bash-4.2"

# ebuild function overrides
src_prepare() {
	eapply_user
}
src_install() {
	dobin "${PN}"
	doman "${PN}.1"
}
