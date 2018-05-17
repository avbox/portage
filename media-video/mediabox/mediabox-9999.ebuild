# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

if [[ ${PV} == 9999* ]]; then
	inherit eutils autotools git-r3
	EGIT_REPO_URI=( "https://github.com/avbox/mediabox.git" )
	if [[ ${PV} == 9999 ]]; then
		EGIT_REPO_URI=( "https://bitbucket.com/frodzdev/mediabox.git" )
		EGIT_BRANCH="staging"
	fi
	KEYWORDS=""
else
	inherit eutils autotools
	SRC_URI="https://github.com/avbox/${PN}/archive/${PV}.tar.gz -> mediabox-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

DESCRIPTION="Lightweight PVR and Media Center Software"
HOMEPAGE="https://sourceforge.net/projects/djmount/"

LICENSE="GPL-3"
SLOT="0"
IUSE="bluetooth debug directfb dri realtime systemd webremote X"

RDEPEND="
	net-fs/avmount
	net-misc/mediatomb
	net-libs/libupnp
	x11-libs/cairo
	x11-libs/pango
	>=net-misc/curl-7.45.0
	>=media-video/ffmpeg-3.3.6
	>=net-libs/libtorrent-rasterbar-1.1.5
	dri? ( x11-libs/libdrm )
	directfb? ( dev-libs/DirectFB )
	X? ( x11-libs/libX11 media-libs/mesa )
	bluetooth? ( net-wireless/bluez )
	webremote? ( >=net-libs/libwebsockets-3.0.0 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf-archive"

src_prepare()
{
	eautoreconf
}

src_configure()
{
	econf \
		$(use_enable debug) \
		$(use_enable X "x11") \
		$(use_enable dri "libdrm") \
		$(use_enable bluetooth) \
		$(use_enable realtime) \
		$(use_enable realtime "ionice")
}

src_install()
{
	default
    dodir /usr/share/xsessions/
    insinto /usr/share/xsessions
    doins "${FILESDIR}/mediabox.desktop"
    dodir /etc/X11/Sessions
    insopts --mode=755
    insinto /etc/X11/Sessions
    doins "${FILESDIR}/mediabox"
}
