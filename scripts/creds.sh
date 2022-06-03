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
# requires manual edit to include secrets
echo mqtt_password: $pwd > secrets.yaml
echo nest_client_id: >> secrets.yaml
echo nest_client_secret: >> secrets.yaml
echo nest_project_id: >> secrets.yaml
echo nest_subscriber_id: >> secrets.yaml
echo august_login_method: >> secrets.yaml
echo august_username: >> secrets.yaml
echo august_password: >> secrets.yaml
echo notify_mail_username: >> secrets.yaml
echo notify_mail_password: >> secrets.yaml
echo notify_mail_sender: >> secrets.yaml
echo notify_mail_recipient: >> secrets.yaml
echo notify_sms_recipient: >> secrets.yaml

# check if docker is running
if docker inspect eclipse-mosquitto | grep "Running" >/dev/null
then
    echo "WARN: Restart docker to set environment variables"
fi

# extract existing password
#cat secrets.env | grep '^MQTT_PASSWORD=.*$' | cut -d'=' -f 2
