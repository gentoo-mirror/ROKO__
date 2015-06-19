# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
RESTRICT="mirror"
inherit eutils systemd

DESCRIPTION="Use openrc init scripts with systemd or other init systems"
HOMEPAGE="https://github.com/vaeth/openrc-wrapper"
SRC_URI="https://github.com/vaeth/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!!<sys-fs/squash_dir-3.2"
# the last dependency is not really needed, but without it the output is ugly,
# and the costs are really not high: sys-apps/gentoo-functions is tiny
RDEPEND="${DEPEND}
|| ( sys-apps/gentoo-functions sys-apps/openrc )"
IUSE=""

src_prepare() {
	epatch_user
}

src_install() {
	dodoc README
	dobin bin/*
	systemd_dounit systemd/system/*
	insinto /usr/share/zsh/site-functions
	doins zsh/*
}
