#!/bin/bash

# Dockerコンテナをバックグラウンドで起動
docker-compose up -d

# MySQLサーバーが起動するまで待機
echo "Waiting for MySQL server to start..."
until docker exec database-creation_mysql mysqladmin ping -h "localhost" --silent; do
    printf "."
    sleep 1
done
echo "MySQL server is up and running."

# データベースのマイグレーションを実行
pnpm db-migrate

# tblsのドキュメントを生成
tbls doc --force mysql://root@localhost:3309/parking

if [ ! -x ./convert-tbls-doc.sh ]; then
  chmod +x ./convert-tbls-doc.sh
fi
# スクリプトを実行
./convert-tbls-doc.sh

if [ ! -x ./exec-schemaspy.sh local ]; then
  chmod +x ./exec-schemaspy.sh local
fi
# exec-schemaspy.shスクリプトを実行
./exec-schemaspy.sh local

# docs/antora-adocディレクトリに移動
cd docs/antora-adoc

# git statusを確認
git status

# git repositoryがなかったら初期化
if [ ! -d .git ]; then
  git init
fi

cd ../..

# Antoraのドキュメントを生成
docker run --rm --platform linux/amd64 -v $PWD:/work -w /work antora/antora antora --fetch antora-playbook.yml

# antora.ymlからバージョンを取得
VERSION=$(grep 'version:' docs/antora-adoc/antora.yml | sed 's/version: //')

# デバッグ情報を表示
echo "Retrieved version: $VERSION"

if [ -z "$VERSION" ]; then
  echo "Failed to retrieve version from antora.yml"
  exit 1
fi

# 出力ディレクトリを作成
OUTPUT_DIR="outputs/antora-db-doc/$VERSION/schemaspy"
mkdir -p "$OUTPUT_DIR"

# docs/schemaspy-raw/の内容をコピー
rsync -av --ignore-existing docs/schemaspy-raw/ "$OUTPUT_DIR/"