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
	KEYWORDS="-*"
else
	inherit eutils autotools
	SRC_URI="https://github.com/avbox/${PN}/archive/${PV}.tar.gz -> mediabox-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

DESCRIPTION="Lightweight PVR and Media Center Software"
HOMEPAGE="https://sourceforge.net/projects/djmount/"

LICENSE="GPL-3"
SLOT="0"
IUSE="bluetooth debug realtime systemd"

RDEPEND="
	net-fs/avmount
	net-misc/mediatomb
	net-p2p/deluge
	net-libs/libupnp
	media-video/ffmpeg
	dev-libs/DirectFB
	x11-libs/cairo
	x11-libs/pango
	>=net-misc/curl-7.45.0"
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
		$(use_enable bluetooth) \
		$(use_enable realtime)
}
