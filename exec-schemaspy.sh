# GitHub Actionsでない場合にのみ.envファイルを読み込む
if [ -z "$CI" ]; then
  if [ -f .env ]; then
    source .env
  else
    echo ".envファイルが見つかりません。"
    exit 1
  fi
fi

# schemaspy.propertiesファイルの生成
cat <<EOL > schemaspy.properties
schemaspy.t=mysql
schemaspy.dp=./mysql-connector-j-9.0.0.jar
schemaspy.db=${DATABASE_NAME}
schemaspy.s=${DATABASE_NAME}
schemaspy.host=${DATABASE_HOST}
schemaspy.port=${DATABASE_PORT}
schemaspy.u=${DATABASE_USER}
schemaspy.p=${DATABASE_PASSWORD}
schemaspy.o=${SCHEMASPY_OUTPUT_DIR}
schemaspy.hq=${SCHEMASPY_DOT_PATH}
schemaspy.imageformat=svg
schemaspy.imagefontadjust=true
EOL

# バージョン情報を引数から取得
if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION=$1

# SchemaSpyの実行
java -jar ./schemaspy-6.2.4.jar -configFile schemaspy.properties

# 出力ディレクトリとファイルの設定
OUTPUT_DIR="./docs/schemaspy-raw"
INDEX_FILE="$OUTPUT_DIR/index.html"

if [ -f "${INDEX_FILE}" ];then
  # .${DATABASE_NAME}を.$VERSIONに置き換え
  sed -i '' "s|<span class=\"navbar-brand\" style=\"padding-left: 0\">.${DATABASE_NAME}</span>|<span class=\"navbar-brand\" style=\"padding-left: 0\">.${VERSION}</span>|" "${INDEX_FILE}"
fi

# schemaspy.propertiesファイルの削除
rm -f schemaspy.properties