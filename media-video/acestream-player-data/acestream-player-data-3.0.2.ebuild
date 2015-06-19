# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

DESCRIPTION="ACE Stream player libraries files"
HOMEPAGE="http://torrentstream.org/"
SRC_URI=" x86? ( http://repo.acestream.org/ubuntu/pool/main/a/${PN}/${PN}_${PV}-1trusty2_i386.deb )
		amd64? ( http://repo.acestream.org/ubuntu/pool/main/a/${PN}/${PN}_${PV}-1trusty2_amd64.deb )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio jack portaudio avahi cddb cdda dvd dirac aac flac ogg lirc mad matroska modplug musepack mpeg
		ieee1394 samba mtp ncurses libproxy speex theora upnp v4l vaapi vcdx vorbis"

LANGS="ach af am ar ast be bg bn br ca cgg ckb co cs da de el en_GB es et eu fa ff fi fr fur ga gl he
		hi hr hu hy id is it ja ka kk km ko lg lt lv mk ml mn ms my nb ne nl nn oc pa pl ps pt_BR pt_PT
		ro ru si sk sl sq sr sv ta tet th tl tr uk vi wa zh_CN zh_TW zu"

for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

CDEPEND=""
DEPEND="media-libs/aalib
		media-libs/libass
		net-libs/gnutls
		>=dev-lang/lua-5.1
		media-libs/libshout[speex=,theora=]
		media-libs/libpng:1.2
		musepack? ( media-sound/musepack-tools )
		modplug? ( media-libs/libmodplug )
		matroska? ( media-libs/libmatroska dev-libs/acestream-libebml media-libs/libmkv )
		media-libs/alsa-lib
		jack? ( media-sound/jack-audio-connection-kit )
		media-libs/libcaca
		>=media-libs/a52dec-0.7.4
		pulseaudio? ( media-sound/pulseaudio )
		portaudio? ( media-libs/portaudio )
		avahi? ( net-dns/avahi )
		|| ( media-video/acestream-ffmpeg[jack=,aac=,modplug=,ieee1394=,speex=,theora=,v4l=,vaapi=,vorbis=,alsa] >=media-video/libav-9.17 )
		media-libs/acestream-x264
		cddb? ( media-libs/libcddb )
		cdda? ( media-libs/libcddb dev-libs/libcdio )
		sys-apps/dbus
		dvd? ( media-libs/libdca media-libs/libdvdnav media-libs/libdvdread )
		dirac? ( media-video/dirac media-libs/schroedinger )
		=media-libs/libdvbpsi-1.0.0
		aac? ( media-libs/faad2 )
		flac? ( media-libs/flac )
		ogg? ( media-libs/libogg media-libs/libkate )
		mad? ( media-libs/libmad )
		mpeg? ( media-libs/libmpeg2 media-sound/twolame )
		dev-libs/fribidi
		=dev-libs/libgcrypt-1.5.4-r100
		dev-libs/libgpg-error
		media-libs/mesa
		dev-qt/qtwebkit
		dev-qt/qtdeclarative
		lirc? ( app-misc/lirc )
		ieee1394? ( sys-libs/libraw1394 sys-libs/libavc1394 media-libs/libdc1394 )
		media-libs/libsdl
		media-libs/sdl-image
		samba? ( net-fs/samba )
		mtp? ( media-libs/libmtp )
		ncurses? ( sys-libs/ncurses:5 )
		libproxy? ( net-libs/libproxy )
		speex? ( media-libs/speex )
		theora? ( media-libs/libtheora )
		upnp? ( net-libs/libupnp )
		v4l? ( media-libs/libv4l )
		vaapi? ( x11-libs/libva )
		vcdx? ( dev-libs/libcdio media-video/vcdimager )
		vorbis? ( media-libs/libvorbis )
		dev-libs/libxml2
		x11-libs/libXpm
		media-libs/schroedinger
		media-libs/taglib
		>=media-plugins/live-2015.04.01"

RDEPEND="${DEPEND}"

RESTRICT="strip"

S="${WORKDIR}"

src_prepare(){
	unpack ${A}
	unpack ./data.tar.xz

	for lang in ${LANGS};do
		for x in ${lang};do
			if ! use linguas_${x}; then
				rm -rf usr/share/locale/${x}
			fi
		done
	done
}
src_install(){
	cp -R usr "${D}"

	$(has_version ">=net-libs/gnutls-3.1.10") && dosym "libgnutls.so" "/usr/$(get_libdir)/libgnutls.so.26"
	dosym "liblua.so" "/usr/$(get_libdir)/liblua5.1.so.0"
	dosym "/usr/$(get_libdir)/liba52.so.0.0.0" "/usr/$(get_libdir)/liba52-0.7.4.so"
	dolib "${FILESDIR}"/liblua5.2.so.0
	dolib "${FILESDIR}"/liblua5.2.so.0.0.0

	use pulseaudio || rm "${D}/usr/lib/acestreamplayer/plugins/audio_output/libpulse_plugin.so"
	use portaudio || rm "${D}/usr/lib/acestreamplayer/plugins/audio_output/libportaudio_plugin.so"
	use v4l || rm "${D}/usr/lib/acestreamplayer/plugins/access/libv4l2_plugin.so"
	use cdda || rm "${D}/usr/lib/acestreamplayer/plugins/access/libcdda_plugin.so"
	use modplug || rm "${D}/usr/lib/acestreamplayer/plugins/demux/libmod_plugin.so"
	use mpeg || rm "${D}/usr/lib/acestreamplayer/plugins/codec/liblibmpeg2_plugin.so"
	use speex || rm "${D}/usr/lib/acestreamplayer/plugins/codec/libspeex_plugin.so"
	use theora || rm "${D}/usr/lib/acestreamplayer/plugins/codec/libtheora_plugin.so"
	use vorbis || rm "${D}/usr/lib/acestreamplayer/plugins/codec/libvorbis_plugin.so"

	if use musepack;then
		dosym "libmpcdec.so" "/usr/$(get_libdir)/libmpcdec.so.6"
	else
		rm "${D}/usr/lib/acestreamplayer/plugins/demux/libmpc_plugin.so"
	fi

	if use matroska;then
		dosym "libmatroska.so" "/usr/$(get_libdir)/libmatroska.so.4"
	else
		rm "${D}/usr/lib/acestreamplayer/plugins/demux/libmkv_plugin.so"
	fi

	if ! use jack;then
		rm "${D}/usr/lib/acestreamplayer/plugins/audio_output/libjack_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/access/libaccess_jack_plugin.so"
	fi

	if ! use dvd;then
		rm "${D}/usr/lib/acestreamplayer/plugins/access/libdvdread_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/access/libdvdnav_plugin.so"
	fi

	if ! use dirac;then
		rm "${D}/usr/lib/acestreamplayer/plugins/demux/libdirac_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/codec/libdirac_plugin.so"
	fi

	if ! use flac;then
		rm "${D}/usr/lib/acestreamplayer/plugins/demux/libflacsys_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/codec/libflac_plugin.so"
	fi

	if ! use ogg;then
		rm "${D}/usr/lib/acestreamplayer/plugins/demux/libogg_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/mux/libmux_ogg_plugin.so"
	fi

	if ! use vcdx;then
		rm "${D}/usr/lib/acestreamplayer/plugins/access/libvcd_plugin.so"
		rm "${D}/usr/lib/acestreamplayer/plugins/codec/libsvcdsub_plugin.so"
	fi
}
