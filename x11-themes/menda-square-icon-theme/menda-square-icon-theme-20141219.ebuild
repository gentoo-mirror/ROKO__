# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Menda Square Icon Theme"
HOMEPAGE="https://github.com/anexation/menda-icon-themes"
GIT_COMMIT="1635665a21342da0ef5178612e9b412031c25655"
SRC_URI="${HOMEPAGE}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-themes/hicolor-icon-theme
	gnome-base/librsvg
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/menda-icon-themes-${GIT_COMMIT}"

src_install(){
	insinto /usr/share/icons
	doins -r Menda-Square
}
