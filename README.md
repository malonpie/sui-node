# Sui Fullnodeの構築方法
詳細は、こちらの記事を参考にしてください  

[Sui Testnet Fullnodeの建て方](https://mirror.xyz/0x78CAFBE493dfEFAbE0F115402Da54A32012a774f/yjXbpuSfDwbwM8ZffqIj6edrfuKxxOcYH9NW56RIqE4)

[Sui Devnet Fullnodeの建て方](https://mirror.xyz/0x78CAFBE493dfEFAbE0F115402Da54A32012a774f/3FP8eKTqtpqF0WsrdDysWiPdy3xZg8gEcRLpVLrQOH8)

# 1. 目的
SuiのDockerでのFullNodeの構築方法を記載します  
Source Codeでの構築方法もありますが、時間を要する & Build時にCPU / RAMリソースを消費するため、Node OperationとしてはDockerでの構築方法を推奨します  

# 2. Server要件
- CPU : 10 cores
- Memory : 32 GB RAM
- Storage: 1 TB NVMe
- OS : Ubuntu version 18.04 (Bionic Beaver)より最新版

ファイアーウォールルール
下記のPortを0.0.0.0/0, ::/0向けに開ける
- 8080 : HTTP
- 9000 : Sui JSON RPC
- 9184 : Metrics

# 3. Install方法
## 3-1. Testnet
`sudo su -`  
`cd $HOME`

`wget -O install-sui-fullnode.sh https://raw.githubusercontent.com/malonpie/sui-node/main/install-sui-fullnode-wave2.sh`

`chmod +x install-sui-fullnode-wave2.sh`  
`./install-sui-fullnode-wave2.sh`


## 3-2. Devnet
`sudo su -`  
`cd $HOME`

`wget -O install-sui-fullnode.sh https://raw.githubusercontent.com/malonpie/sui-node/main/install-sui-fullnode.sh`

`chmod +x install-sui-fullnode.sh`  
`./install-sui-fullnode.sh`
