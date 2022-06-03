# 概要
- WAFルールを作成
  - リクエストURIパスが特定のパターン かつ クライアントIPが特定の値「ではない」場合にアクセスをブロック
- API Gatewayを作成
  - `/example/path1`

# 参考
Resource: aws_wafv2_web_acl_association
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association#example-usage

# コマンド
```
terraform -chdir=./src init -upgrade -reconfigure
terraform -chdir=./src fmt -recursive
terraform -chdir=./src validate
terraform -chdir=./src plan
terraform -chdir=./src apply -auto-approve
terraform -chdir=./src destroy -auto-approve
```
