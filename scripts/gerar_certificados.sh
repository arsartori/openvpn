# Exporta variáveis
export OPENVPN_DIR="/opt/docker/openvpn"
export CERTS_DIR=$OPENVPN_DIR/certs
# Cria pasta para os certificados
mkdir -p $CERTS_DIR
# Gera arquivo dh
openssl dhparam -out $CERTS_DIR/dh.pem 2048
# Gera certificado da CA
openssl req -nodes -new -x509 -days 3650 -config /etc/ssl/openssl.cnf -extensions v3_ca -newkey rsa:4096 -keyout $CERTS_DIR/certs/ca.key -out $CERTS_DIR/certs/ca.crt
# Gerar certificado do Server
openssl req -new -newkey rsa:4096 -config /etc/ssl/openssl.cnf -extensions v3_req -nodes -keyout $CERTS_DIR/certs/server.key -out $CERTS_DIR/certs/server.csr
openssl x509 -req -days 365 -extfile /etc/ssl/openssl.cnf -extensions v3_req -in $CERTS_DIR/certs/server.csr -CA $CERTS_DIR/certs/ca.crt -CAkey $CERTS_DIR/certs/ca.key -CAcreateserial -out $CERTS_DIR/certs/server.crt