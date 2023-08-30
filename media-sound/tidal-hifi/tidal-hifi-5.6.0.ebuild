# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# File was automatically generated by automatic-ebuild-maker
# https://github.com/BlueManCZ/automatic-ebuild-maker

EAPI=7
inherit unpacker xdg

DESCRIPTION="Tidal on Electron with widevine(hifi) support"
HOMEPAGE="https://github.com/Mastermindzh/tidal-hifi"
SRC_URI="https://github.com/Mastermindzh/tidal-hifi/releases/download/${PV}/tidal-hifi_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="appindicator doc libnotify"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/tidal-hifi/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/tidal-hifi/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/tidal-hifi" || die "mv failed"
	fi
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/tidal-hifi" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/tidal-hifi/"* || die "dodoc failed"
	fi

	dosym "/opt/tidal-hifi/tidal-hifi" "/usr/bin/tidal-hifi" || die "dosym failed"
}
