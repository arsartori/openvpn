# OpenVPN 

### Versões do ambiente
	Alpine 3.15
	OpenVPN 2.5.6

### Download Docker Image
	docker pull arsartori/openvpn:latest

### Create directory as root
	mkdir -p /opt/docker/openvpn/certs
	cd /opt/docker/openvpn/certs

### Create certificates
	openssl dhparam -out dh.pem 2048  

### Create CA Certificate
	openssl req -nodes -new -x509 -days 3650 -config /etc/ssl/openssl.cnf -extensions v3_ca -newkey rsa:4096 \
	-keyout ca.key -out ca.crt -subj "/C=XXX/ST=XXX/O=XXX/CN=XXX"

### Create Server Certificate
	openssl req -nodes -new -x509 -days 730 -config /etc/ssl/openssl.cnf -extensions v3_req -newkey rsa:4096 \
	-keyout server.key -CA ca.crt -CAkey ca.key -out server.crt -subj "/C=XXX/ST=XXX/O=XXX/CN=XXX" \
	-addext "extendedKeyUsage = serverAuth, clientAuth"

### Start OpenVPN
	cd /opt/docker/openvpn
	docker compose up -d