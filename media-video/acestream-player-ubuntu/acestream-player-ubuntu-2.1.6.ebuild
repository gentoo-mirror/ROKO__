# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="ACE Stream HD multimedia player based on VLC"
HOMEPAGE="http://torrentstream.org/"
SRC_URI=" x86? ( http://repo.acestream.org/ubuntu/pool/main/a/acestream-player/acestream-player_2.1.6-1raring2_i386.deb )
		amd64? ( http://repo.acestream.org/ubuntu/pool/main/a/acestream-player/acestream-player_2.1.6-1raring2_amd64.deb )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND=""
DEPEND="media-video/acestream-player-data
		net-p2p/acestream-engine-ubuntu"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare(){
	unpack ${A}
	unpack ./data.tar.gz
}
src_install(){
	cp -R usr "${D}"
}
