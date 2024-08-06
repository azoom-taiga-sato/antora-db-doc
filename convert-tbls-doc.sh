#!/bin/bash

# ベースディレクトリ
BASE_DIR="tbls/dbdoc"
ADOC_DIR="docs/modules/tbls/pages"
IMAGE_DIR="docs/modules/tbls/images"
NAV_FILE="docs/modules/tbls/nav.adoc"

# AsciiDocディレクトリが存在しない場合は作成
mkdir -p "${ADOC_DIR}"
# 画像ディレクトリが存在しない場合は作成
mkdir -p "${IMAGE_DIR}"

# nav.adocファイルを初期化
echo "" > "${NAV_FILE}"

# 特定のファイル名を変更
find $BASE_DIR -name "__drizzle_migrations.md" -exec mv {} "${BASE_DIR}/drizzle_migrations.md" \;
find $BASE_DIR -name "__drizzle_migrations.svg" -exec mv {} "${BASE_DIR}/drizzle_migrations.svg" \;

# 参照を更新
# find $BASE_DIR -type f -exec sed -i '' 's/__drizzle_migrations/drizzle_migrations/g' {} +
find $BASE_DIR -type f -exec sed -i 's/__drizzle_migrations/drizzle_migrations/g' {} +

# mdファイルの取得
find $BASE_DIR -name "*.md" | while read md_file; do
    # 出力ファイルのパス
    adoc_file="${ADOC_DIR}/$(basename "${md_file%.md}.adoc")"

    # mdファイル内にmd文字列が含まれているか確認
    if grep -q '.md' "${md_file}"; then
        # md文字列をhtmlに置換 (Macの場合は -i '' を使用)
        # sed -i '' 's/\.md/\.html/g' "${md_file}"
        sed -i 's/\.md/\.html/g' "${md_file}"
        echo "md文字列あり"
    fi

    # pandocを使ってmdファイルをadocに変換
    docker run --rm -v "$(pwd)":/source pandoc/core -f markdown -t asciidoc -o "/source/${adoc_file}" "/source/${md_file}"

    # adoc_fileがREADME.adocの場合、ページの先頭に"= tbls Overview"を追加
    if [ "$(basename "${adoc_file}")" = "README.adoc" ]; then
        # sed -i '' '1s/^/= tbls Overview\n\n/' "${adoc_file}"
        sed -i '1s/^/= tbls Overview\n\n/' "${adoc_file}"
        echo "README.adocに'tbls Overview'を追加しました"
        # nav.adocにREADME.adocを先頭に追加
        # sed -i '' '1s/^/* xref:README.adoc[]/' "${NAV_FILE}"
        sed -i '1s/^/* xref:README.adoc[]/' "${NAV_FILE}"
    else
        # nav.adocにその他のファイルを追加
        echo "** xref:$(basename "${adoc_file}")[]" >> "${NAV_FILE}"
        cat "${NAV_FILE}"
    fi

    # SVGファイルの参照を変更せずにコピー
    grep -o '!\[.*\](.*\.svg)' "${md_file}" | sed -E 's/!\[.*\]\((.*\.svg)\)/\1/' | while read svg_path; do
        svg_path_relative=$(basename "${svg_path}")
        
        # デバッグ用エコー
        echo "コピー元: ${BASE_DIR}/${svg_path_relative}"
        echo "コピー先: ${IMAGE_DIR}/${svg_path_relative}"
        
        cp "${BASE_DIR}/${svg_path_relative}" "${IMAGE_DIR}/${svg_path_relative}"
    done
done