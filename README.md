# docker-openvpn
Simple docker image for OpenVPN

### Create variables  
OPENVPN_DIR="/opt/openvpn"  
CERTS_DIR=$OPENVPN_DIR/certs  
  
### Create directory
mkdir -p $CERTS_DIR  

### Create certificates
openssl dhparam -out $CERTS_DIR/dh2048.pem 2048  
touch $CERTS_DIR/index.txt  
echo "01" > $CERTS_DIR/serial  
cp /etc/ssl/openssl.cnf $OPENVPN_DIR/  

### Create CA Certificate
openssl req -nodes -new -x509 -days 3650 -config $OpenVPN_DIR/openssl.cnf -extensions v3_ca -newkey rsa:4096 -keyout $OpenVPN_DIR/certs/ca.key -out $OpenVPN_DIR/certs/ca.crt

### Create Server Certificate
openssl req -new -newkey rsa:4096 -config openssl.cnf -extensions v3_server -nodes -keyout $OpenVPN_DIR/certs/serverkey.pem -out $OpenVPN_DIR/certs/server.csr  
openssl x509 -req -days 365 -extfile openssl.cnf -extensions v3_server -in $OpenVPN_DIR/certs/server.req -CA $OpenVPN_DIR/certs/ca.crt -CAkey $OpenVPN_DIR/certs/ca.key -CAcreateserial -out $OpenVPN_DIR/certs/server.crt

### Start OpenVPN
```
docker run -d --name docker-openvpn \
	-p 1194:1194/udp \
	--cap-add=NET_ADMIN \
	-v $OpenVPN_DIR:/etc/openvpn \
	docker-openvpn
```

### Client
openssl genrsa -out client.key 4096  
openssl req -new -key client.key -out client.reg -config openssl.cnf -extensions v3_client  
openssl x509 -req -days 365 -extfile openssl.cnf -extensions v3_client -in client.reg -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt  
