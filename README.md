# tetris_score_server_frontend

以下サーバのフロントエンドに関する検討用として作成(仮)

https://github.com/seigot/tetris_score_server  
https://github.com/seigot/tetris_battle_server

## 環境構築

### docker engine のインストール

[docker インストール](https://docs.docker.jp/engine/installation/index.html)を参照

### docker compose のインストール

[docker compoer のインストール](https://docs.docker.jp/compose/install.html#compose)を参照

### docker compose の実行

`/tetris_score_server_frontend`に移動して

```
docker-compose up
```

を実行する。

### flutter ホスティングの実行

まずは起動中のコンテナに入る

```
docker compose exec [container id] bash
```

次にホスティングを実行(makefile に記載している)

```
make run
```

リロードがオートではないので、ソースファイルの更新時にはこちらのターミナルに"r"を入力するとリロードが走る
