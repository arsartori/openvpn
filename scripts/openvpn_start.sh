#!/bin/sh
cd $OPENVPN
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
echo "Starting OpenVPN Server"
if [ ! -e $OPENVPN/certs/ta.key ]; then
    openvpn --genkey secret $OPENVPN/certs/ta.key
fi
exec openvpn --config $OPENVPN/openvpn.conf
