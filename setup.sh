# make script dir current
cd $(dirname $0)
cd ./scripts

sh ./install.sh
sh ./certs.sh
sh ./creds.sh
sh ./volumes.sh
sh ./start-docker.sh
