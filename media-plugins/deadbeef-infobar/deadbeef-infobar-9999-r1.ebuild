# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit mercurial

DESCRIPTION="Infobar plugin for DeadBeeF showing lyrics."
HOMEPAGE="https://bitbucket.org/dsimbiriatin/deadbeef-infobar/wiki/Home"
EHG_REPO_URI="https://bitbucket.org/dsimbiriatin/deadbeef-infobar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk2 gtk3"
REQUIRED_USE="|| ( ${IUSE} )"

DEPEND_COMMON="
	|| (
		<media-sound/deadbeef-0.6[curl]
		<media-sound/deadbeef-0.6[cover]
		<media-sound/deadbeef-0.6[lastfm]
		)
	gtk2? ( <media-sound/deadbeef-0.6[gtk2] )
	gtk3? ( <media-sound/deadbeef-0.6[gtk3] )
	dev-libs/libxml2"

RDEPEND="${DEPEND_COMMON}"
DEPEND="${DEPEND_COMMON}"
S="${WORKDIR}"

src_compile() {
	if use gtk2; then
	  emake gtk2
	fi

	if use gtk3; then
	  emake gtk3
	fi
}

src_install() {
	if use gtk2; then
	  insinto /usr/$(get_libdir)/deadbeef
	  doins gtk2/ddb_infobar_gtk2.so
	fi

	if use gtk3; then
	  insinto /usr/$(get_libdir)/deadbeef
	  doins gtk3/ddb_infobar_gtk3.so
	fi
}
