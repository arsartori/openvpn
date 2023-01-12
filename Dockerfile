FROM alpine:3.15
LABEL maintainer="Andre Sartori <pathux.dev@gmail.com>"
RUN apk add --no-cache openvpn iptables
ENV OPENVPN=/etc/openvpn
EXPOSE 1194/udp
ADD openvpn_start.sh /
RUN chmod a+x /openvpn_start.sh
CMD ["openvpn_start.sh"]
