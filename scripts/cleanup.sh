# make script dir current
cd $(dirname $0)

# cleanup temp dirs
cd ..
rm -rf ./local/certs
rm -rf ./local/creds
