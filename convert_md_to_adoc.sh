#!/bin/bash

# ベースディレクトリ
BASE_DIR="tbls/dbdoc"
OUTPUT_DIR="docs/modules/dbdoc/pages"

# mdファイルの取得
find $BASE_DIR -name "*.md" | while read md_file; do
    # 出力ファイルのパス
    adoc_file="${OUTPUT_DIR}/$(basename "${md_file%.md}.adoc")"

    # pandocを使ってmdファイルをadocに変換
    docker run --rm -v "$(pwd)":/source pandoc/core -f markdown -t asciidoc -o "/source/${adoc_file}" "/source/${md_file}"

    # SVGファイルの参照を変更し、コピー
    grep -o '!\[.*\](.*\.svg)' "${md_file}" | sed -E 's/!\[.*\]\((.*\.svg)\)/\1/' | while read svg_path; do
        svg_path_relative=$(basename "${svg_path}")
        
        # デバッグ用エコー
        echo "コピー元: ${BASE_DIR}/${svg_path_relative}"
        echo "コピー先: ${OUTPUT_DIR}/${svg_path_relative}"
        
        cp "${BASE_DIR}/${svg_path_relative}" "${OUTPUT_DIR}/${svg_path_relative}"
        
        # デバッグ用エコー
        echo "置換対象: ${svg_path} -> ${svg_path_relative}"
        
        sed -i "s|${svg_path}|${svg_path_relative}|g" "${adoc_file}"
    done
done