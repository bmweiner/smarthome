# make base dir current
cd $(dirname $0); cd ..
base=$(pwd)

sh ./scripts/fix-permissions.sh

# homeassistant
mkdir -p ./local/homeassistant
mkdir -p ./local/homeassistant/certs
mkdir -p ./local/homeassistant/python_scripts

ln -sf $base/config/configuration.yaml ./local/homeassistant/configuration.yaml
ln -sf $base/config/automation.yaml ./local/homeassistant/automation.yaml
ln -sf $base/config/customize.yaml ./local/homeassistant/customize.yaml
ln -sf $base/config/group.yaml ./local/homeassistant/group.yaml
ln -sf $base/config/scene.yaml ./local/homeassistant/scene.yaml
ln -sf $base/config/script.yaml ./local/homeassistant/script.yaml
ln -sf $base/config/sensor.yaml ./local/homeassistant/sensor.yaml
ln $base/config/python_scripts/wiki_today.py ./local/homeassistant/python_scripts/wiki_today.py

cp $base/local/certs/ca.crt ./local/homeassistant/certs/ca.crt
cp $base/local/certs/client.crt ./local/homeassistant/certs/client.crt
cp $base/local/certs/client.key ./local/homeassistant/certs/client.key

cp $base/local/creds/secrets.yaml ./local/homeassistant/secrets.yaml

# mosquitto
mkdir -p ./local/mosquitto/config
mkdir -p ./local/mosquitto/certs

ln -sf $base/config/mosquitto.conf ./local/mosquitto/config/mosquitto.conf

cp $base/local/certs/ca.crt ./local/mosquitto/certs/ca.crt
cp $base/local/certs/server.crt ./local/mosquitto/certs/server.crt
cp $base/local/certs/server.key ./local/mosquitto/certs/server.key

cp $base/local/creds/passwd ./local/mosquitto/passwd

# zwavejs2mqtt
mkdir -p ./local/zwavejs2mqtt
