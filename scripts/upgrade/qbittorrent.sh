#!/bin/bash
# qBittorrent Installer for swizzin
# Author: liara


if [[ -f /tmp/.install.lock ]]; then
  export log="/root/logs/install.log"
else
  export log="/root/logs/swizzin.log"
fi
# Source the required functions
. /etc/swizzin/sources/functions/qbittorrent
. /etc/swizzin/sources/functions/libtorrent
. /etc/swizzin/sources/functions/utils
. /etc/swizzin/sources/functions/fpm

whiptail_qbittorrent
if ! skip_libtorrent_rasterbar; then
    whiptail_libtorrent_rasterbar
    build_libtorrent_rasterbar
fi

build_qbittorrent
for user in ${users[@]}; do
    systemctl try-restart qbittorrent@${user}
done