# make script dir current
cd $(dirname $0)
cd ./scripts

sh ./install.sh
sh ./certs.sh
sh ./volumes.sh
sh ./start-docker.sh
sh ./fix-permissions.sh
