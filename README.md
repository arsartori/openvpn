# OpenVPN 2.5.6

### Create directory as root
	mkdir -p /opt/docker/openvpn/certs  

### Create certificates
	cd /opt/docker/openvpn/certs
	openssl dhparam -out dh.pem 2048  

### Create CA Certificate
	openssl req -nodes -new -x509 -days 3650 -config /etc/ssl/openssl.cnf -extensions v3_ca -newkey rsa:4096 -keyout ca.key -out ca.crt

### Create Server Certificate
	openssl req -new -newkey rsa:4096 -config /etc/ssl/openssl.cnf -extensions v3_req -nodes -keyout server.key -out server.csr
	openssl x509 -req -days 365 -extfile /etc/ssl/openssl.cnf -extensions v3_req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

### Create Client Certificate
	openssl genrsa -out client.key 4096
	openssl req -new -key client.key -out client.csr -config /etc/ssl/openssl.cnf -extensions v3_req
	openssl x509 -req -days 365 -extfile /etc/ssl/openssl.cnf -extensions v3_req -in client.scr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt

### Start OpenVPN
	docker compose up -d