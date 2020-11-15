# make base dir current
cd $(dirname $0); cd ..

# fix permissions
sudo chown -fR $USER:$USER ./local
sudo chown -fR $USER:$USER ./config
