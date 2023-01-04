# Sui Fullnodeの構築方法
詳細は、こちらの記事を参考にしてください  
[Sui Devnet Fullnodeの建て方](https://mirror.xyz/0x78CAFBE493dfEFAbE0F115402Da54A32012a774f/3FP8eKTqtpqF0WsrdDysWiPdy3xZg8gEcRLpVLrQOH8)

# 1. 目的
SuiのDockerでのFullNodeの構築方法を記載します  
Source Codeでの構築方法もありますが、時間を要する & Build時にCPU / RAMリソースを消費するため、Node OperationとしてはDockerでの構築方法を推奨します  

また、Suiにおいても報酬付きのテストネット (Wave1) が開かれるましたが、その際にもFullnodeの登録が必須でした  
Wave2は2023年上旬予定ですが、参加には開発者ネットでのFullNode構築が必須になると想定されますので、ぜひノードを建ててみてください

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
## 3-1. Rootユーザ (特権ユーザ)になる
`sudo su -`  
`cd $HOME`

## 3-2. installerをダウンロード
`wget -O install-sui-fullnode.sh https://raw.githubusercontent.com/malonpie/sui-node/main/install-sui-fullnode.sh`


## 3-3. installerを実行
`chmod +x install-sui-fullnode.sh`  
`./install-sui-fullnode.sh`

## 3-4. Fullnode起動完了
無事Installerが動作すれば、自動でFullnodeが起動されます  
下記のような画面になればOKです  

Sui Node Versionは、SuiのDiscordにある #devnet-updatesチャネルに記載のある最新Versionと同じ数字であることを確認ください  


## 3-5. 動作の確認
SuiのCommunityメンバー (公式メンバーではない有志)が作成したNode checkerサイトがあります  
こちらに、NodeのIPを入れて確認してみてください  
(Installerの一番最後に表示されているものが、NodeのIPです)  

同期するのに時間を要するため、Sync Statusが100%になるまで時間がかかります  
そのため、Node構築後すぐの確認観点としては、Average Sync Speedが50tps以上であれば問題ありません  

[Scale3 - Sui Devnet Node Checker](www.scale3labs.com)
