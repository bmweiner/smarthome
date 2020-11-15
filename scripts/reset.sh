# make script dir current
cd $(dirname $0)

sh ./fix-permissions.sh
docker-compose down
sh ./clear-docker.sh

cd ..
rm -rf ./local
