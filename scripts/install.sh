# init vars
eval user=$USER
if [ "$USER" = "root" ]; then
  eval user=$SUDO_USER
fi

#update env
sudo apt-get update
sudo apt-get upgrade -y

#install openssl
sudo apt-get install -y openssl

#install docker
sudo apt-get install -y docker.io docker-compose
sudo groupadd -f docker
sudo usermod -aG docker $user
