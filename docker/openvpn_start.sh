#!/bin/sh
cd $OPENVPN
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
echo "Starting OpenVPN Server"
if [ ! -e /etc/openvpn/certs/ta.key ]; then
    openvpn --genkey --secret /etc/openvpn/certs/ta.key
fi
exec openvpn --config $OPENVPN/openvpn.conf
