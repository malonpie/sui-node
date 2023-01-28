#!/bin/bash

echo "=================================================="
echo -e "\033[0;35m"

echo " __  __ ____  ";
echo "|  \/  |  _ \ ";
echo "| |\/| | |_) |";
echo "| |  | |  __/ ";
echo "|_|  |_|_|    ";

echo -e "\e[0m"
echo "=================================================="

sleep 2

echo "=================================================="

echo -e "\e[1m\e[32m1. Install Docker \e[0m" && sleep 1
cd $HOME

echo -e "\e[1m\e[32m1.1 Install list of dependencies \e[0m" && sleep 1
sudo apt update -y
sudo apt upgrade -y
sudo apt install jq -y

echo -e "\e[1m\e[32m1.1 Installing Docker... \e[0m" && sleep 1
sudo apt-get install ca-certificates curl gnupg lsb-release wget -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo -e "\e[1m\e[32m1.2 Installing Docker Compose v2.12.2 ... \e[0m" && sleep 1
sudo mkdir -p ~/.docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose
sudo chown $USER /var/run/docker.sock

echo "=================================================="

echo -e "\e[1m\e[32m2. Install Sui \e[0m" && sleep 1

echo -e "\e[1m\e[32m2.1 Make dir \e[0m" && sleep 1
mkdir -p $HOME/testnet
cd $HOME/testnet

echo -e "\e[1m\e[32m2.2 Download docker-compose.yaml \e[0m" && sleep 1
wget https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml

echo -e "\e[1m\e[32m2.3 Download fullnode.yaml \e[0m" && sleep 1
wget -O fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/crates/sui-config/data/fullnode-template.yaml

echo -e "\e[1m\e[32m2.4 Download genesis.blob \e[0m" && sleep 1
wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob

echo "=================================================="

echo -e "\e[1m\e[32m3. Run Sui \e[0m" && sleep 1

echo -e "\e[1m\e[32m3.1 Download testnet image \e[0m" && sleep 1
IMAGE="mysten/sui-node:2698314d139a3018c2333ddaa670a7cb70beceee"
sed -i.bak "s|image:.*|image: $IMAGE|" $HOME/sui/docker-compose.yaml

docker compose pull

echo -e "\e[1m\e[32m3.2 Run fullnode \e[0m" && sleep 1
docker compose up -d

echo "=================================================="

echo -e "\e[1m\e[32m4. Download Node Checker \e[0m" && sleep 1
wget -O check-tps.sh https://raw.githubusercontent.com/malonpie/sui-node/main/check-tps.sh
chmod +x check-tps.sh

echo "=================================================="

echo -e "\e[1m\e[32mInfo \e[0m" && sleep 1

echo -e "\e[1m\e[32mDocker process: \e[0m"
echo -e "\e[1m\e[39m    $(docker ps) \n \e[0m"

echo -e "\e[1m\e[32mNode TPS: \e[0m"
echo -e "\e[1m\e[39m    $(./check-tps.sh) \n \e[0m"

echo -e "\e[1m\e[32mSui Node Version: \e[0m"
echo -e "\e[1m\e[39m    $(curl --location --request POST 127.0.0.1:9000 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' 2>/dev/null | jq -r .result.info.version) \n \e[0m"

echo -e "\e[1m\e[32mIP Info: \e[0m"
echo -e "\e[1m\e[39m    $(curl inet-ip.info) \n \e[0m"

echo "=================================================="
