# make base dir current
cd $(dirname $0); cd ..

# create creds
mkdir -p ./local/creds
cd ./local/creds

# mosquitto client credentials and network key
usn=mqtt
pwd=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
echo MQTT_USERNAME=$usn > secrets.env
echo MQTT_PASSWORD=$pwd >> secrets.env

key=$(openssl rand -hex 16 | sed -e 's/\(..\)/0x\1,/g' -e 's/, $//')
echo OZW_NETWORK_KEY=$key >> secrets.env

# mosquitto broker password
echo $usn:$pwd > passwd
mosquitto_passwd -U passwd

# home assistant secrets file
echo mqtt_password: $pwd > secrets.yaml

# check if docker is running
if docker inspect eclipse-mosquitto | grep "Running" >/dev/null
then
    echo "WARN: Restart docker to set environment variables"
fi

# extract existing password
#cat secrets.env | grep '^MQTT_PASSWORD=.*$' | cut -d'=' -f 2

