# make base dir current
cd $(dirname $0); cd ..

# create certs
mkdir -p ./local/certs
cd ./local/certs

host=localhost
client=$(cat /etc/hostname)

# certificate authority
openssl genrsa -out ca.key
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt -subj "/C=US/ST=state/L=city/O=ca/OU=ca/CN=$host"

# server keys
openssl genrsa -out server.key
openssl req -new -key server.key -out server.csr -subj "/C=US/ST=state/L=city/O=server/OU=server/CN=$host"
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650

# client keys
openssl genrsa -out client.key
openssl req -new -key client.key -out client.csr -subj "/C=US/ST=state/L=city/O=client/OU=client/CN=$client"
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 3650
