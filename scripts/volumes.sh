# make base dir current
cd $(dirname $0); cd ..
base=$(pwd)

sh ./scripts/fix-permissions.sh

# homeassistant
mkdir -p ./local/homeassistant
mkdir -p ./local/homeassistant/certs

ln -sf $base/config/configuration.yaml ./local/homeassistant/configuration.yaml

cp $base/local/certs/ca.crt ./local/homeassistant/certs/ca.crt
cp $base/local/certs/client.crt ./local/homeassistant/certs/client.crt
cp $base/local/certs/client.key ./local/homeassistant/certs/client.key

# mosquitto
mkdir -p ./local/mosquitto/config
mkdir -p ./local/mosquitto/certs

ln -sf $base/config/mosquitto.conf ./local/mosquitto/config/mosquitto.conf

cp $base/local/certs/ca.crt ./local/mosquitto/certs/ca.crt
cp $base/local/certs/server.crt ./local/mosquitto/certs/server.crt
cp $base/local/certs/server.key ./local/mosquitto/certs/server.key

# openzwave
mkdir -p ./local/openzwave
