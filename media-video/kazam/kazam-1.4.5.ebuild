# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A screencasting program with design in mind"
HOMEPAGE="https://launchpad.net/kazam"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hzbd/${PN}"
else
	SRC_URI="https://launchpad.net/${PN}/stable/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-libs/gobject-introspection
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	x11-libs/gtk+:3
	x11-libs/pango[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/libwnck:3[introspection]
	virtual/ffmpeg
	media-libs/libmatroska:0/6
	media-libs/libtheora
	gnome-base/gnome-desktop:3[introspection]
"
RDEPEND="${DEPEND}
	dev-libs/keybinder:3[introspection]
	dev-libs/libappindicator:3[introspection]
"

PATCHES=(
	"${FILESDIR}/version.patch"
	"${FILESDIR}/${PN}-fix-conf.patch" )
