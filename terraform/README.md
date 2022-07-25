# terraformによるAWSリソースの定義

[terraform](https://www.terraform.io/)について

### 利点
- リソース定義をコンソールのGUIではなく、コードで行うことで管理を容易にする
- AWSに限らずGCPやAZUREも同様のコードで管理できる

### 環境構築
1．terraformのインストール→[terraformダウンロードサイト](https://www.terraform.io/downloads)  
2. aws cliをインストール→[ダウンロードサイト](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html)  
3. aws cliの認証情報を設定→[参考サイト](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html)
### 実施手順
`/terraform`フォルダに移動したあと、  
```
terraform init
```
でterraformの初期化
```
terraform plan
```
で作成した.tfファイルの検証
```
terraform apply
```
でcloud環境に、作成した.tfファイルに基づいてリソース作成適用