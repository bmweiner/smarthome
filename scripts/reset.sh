# make script dir current
cd $(dirname $0)

sh ./fix-permissions.sh
sh ./stop-docker.sh
sh ./clear-docker.sh

cd ..
rm -rf ./local
