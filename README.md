# OpenVPN 

### Versions
	Alpine 3.15
	OpenVPN 2.5.6

### Download Docker Image
	docker pull arsartori/openvpn:latest

### Create directory as root
	mkdir -p /opt/docker/openvpn/certs  

### Create certificates
	openssl dhparam -out /opt/docker/openvpn/certs/dh.pem 2048  

### Create CA Certificate
	openssl req -nodes -new -x509 -days 3650 -config /etc/ssl/openssl.cnf -extensions v3_ca -newkey rsa:4096 -keyout /opt/docker/openvpn/certs/ca.key -out /opt/docker/openvpn/certs/ca.crt

### Create Server Certificate
	openssl req -new -newkey rsa:4096 -config /etc/ssl/openssl.cnf -extensions v3_req -nodes -keyout /opt/docker/openvpn/certs/server.key -out /opt/docker/openvpn/certs/server.csr
	openssl x509 -req -days 365 -extfile /etc/ssl/openssl.cnf -extensions v3_req -in /opt/docker/openvpn/certs/server.csr -CA /opt/docker/openvpn/certs/ca.crt -CAkey /opt/docker/openvpn/certs/ca.key -CAcreateserial -out /opt/docker/openvpn/certs/server.crt

### Create Client Certificate
	openssl genrsa -out /opt/docker/openvpn/certs/client.key 4096
	openssl req -new -key /opt/docker/openvpn/certs/client.key -out /opt/docker/openvpn/certs/client.csr -config /etc/ssl/openssl.cnf -extensions v3_req
	openssl x509 -req -days 365 -extfile /etc/ssl/openssl.cnf -extensions v3_req -in /opt/docker/openvpn/certs/client.scr -CA /opt/docker/openvpn/certs/ca.crt -CAkey /opt/docker/openvpn/certs/ca.key -CAcreateserial -out /opt/docker/openvpn/certs/client.crt

### Start OpenVPN
	cd /opt/docker/openvpn
	docker compose up -d