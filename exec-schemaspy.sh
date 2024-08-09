# .envファイルの読み込み
if [ -f .env ]; then
  source .env
else
  echo ".envファイルが見つかりません。"
  exit 1
fi

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