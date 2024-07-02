export OPENVPN_DIR="/opt/openvpn"
export CERTS_DIR=$OPENVPN_DIR/certs

mkdir -p $CERTS_DIR

openssl dhparam -out $CERTS_DIR/dh2048.pem 2048
touch $CERTS_DIR/index.txt
echo "01" > $CERTS_DIR/serial
cp /etc/ssl/openssl.cnf $OPENVPN_DIR/

openssl req -nodes -new -x509 -days 3650 -config $OPENVPN_DIR/openssl.cnf -extensions v3_req -newkey rsa:4096 -keyout $OPENVPN_DIR/certs/ca.key -out $OPENVPN_DIR/certs/ca.crt

openssl req -new -newkey rsa:4096 -config $OPENVPN_DIR/openssl.cnf -extensions v3_req -nodes -keyout $OPENVPN_DIR/certs/server.key -out $OPENVPN_DIR/certs/server.csr
openssl x509 -req -days 365 -extfile $OPENVPN_DIR/openssl.cnf -extensions v3_req -in $OPENVPN_DIR/certs/server.csr -CA $OPENVPN_DIR/certs/ca.crt -CAkey $OPENVPN_DIR/certs/ca.key -CAcreateserial -out $OPENVPN_DIR/certs/server.crt

