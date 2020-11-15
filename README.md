# smarthome

Setup scripts for a basic install and configuration of Home Assistant core on
Raspberry Pi 4 Model B with a combination Z-Wave and Zigbee usb controller
(HUSBZB-1). This setup installs docker images for Home Assistant, Eclipse
Mosquitto, and Open Z-Wave. Open SSL is used to create certificates which enable
SSL/TLS and certificate based authentication for Mosquitto.

## Hardware Setup

Install Ubuntu Server on an SD card and configure SSH.

 1. Flash SD card with Ubuntu Server 20.03.1 LTS 64-bit (Focal)
 2. `touch ssh` in SD card root directory to enable ssh
 3. Insert SD card and HUSBZB-1 to Pi and power on
 4. `ssh-keygen -t rsa -b 4096` to create ssh key 
 5. `ssh-copy-id -i ~/.ssh/id_rsa pi@<host>` to copy ssh key to PI
 6. `vi .ssh/config` to add pi
    Host ha
        HostName <host>
        User ubuntu
        IdentityFile ~/.ssh/id_rsa
 7. `ssh pi`

## Software Setup

Install software on the 

 1. `ssh pi`
 2. Clone `smarthome` repo
 3. (optional) restore home assistant config, see `Backup and Restore` section
 4. `sh ./setup.sh` to install and start software
 5. Login to Home assistant at `http://<host>:8123` and configure, if necessary
 6. Navigate to config > Integrations
 7. Add OpenZWave (beta)
 8. Add Zigbee Home Automation, select `/dev/ttyUSB1` as USB controller
 9. `sh ./scripts/fix-permissions.sh` to set volume permissions to non-root

## Backup and Restore

Home assistant settings are stored in the docker container under `/config`. This
directory is mapped to `~/smarthome/local/homeassistant`. Scripts for backup and 
restore of this directory to a backup machine are provided in `\scripts`. These
are simple scripts which use SCP to copy the folder either to or from the Pi.
Please examine the scripts prior to executing to ensure parameters are correct.
These scripts should be executed from the backup machine where the ha ssh config 
containing the ha Host settings and identity file are stored.

## Notes

### Open Z-Wave GUI
Open Z-Wave provides a desktop GUI to configure devices:
[Open Z-Wave Desktop GUI](https://github.com/OpenZWave/ozw-admin)

Launch app and configure Remote OZWDaemon to connect
 * Remote Host: <host>
 * Port: 8883 or 1983
 * Authentication Key: robot/local/certs/?

### Docker-Compose Commands 

Start

    docker-compose up -d

Stop

    docker-compose down

Restart

    docker-compose restart

Update

    docker-compose pull
    docker-compose build

### Docker Commands

Connect to container shell

    docker exec -it home-assistant /bin/sh

Remove Containers and volumes

    docker rm -f $(docker ps -a -q)
    docker volume rm $(docker volume ls -q)

### Home Assistant configuration.yaml

Any new intgrations must use configuration via the UI. Some integrations will
be allowed in YAML, e.g. integration of transports.
[Source](https://www.home-assistant.io/blog/2020/04/14/the-future-of-yaml/)
