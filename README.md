# 目次
- [1 Antora](#Antora)
- [2 Pandoc](#Pandoc)

# Antora
* 詳細は[こちらのリポジトリ](https://github.com/azoom-taiga-sato/antora-demo-playbook)を参照

## セットアップ
1. 環境設定
    ```bash
    $ npm i -D -E antora
    ```
2. `antora-playbook.yml`でサイトの詳細設定

3. `$ npx antora --fetch antora-playbook.yml`でサイトを生成して、ローカルで確認

4. 以下のようなフォルダ構成で作成。
    ```bash
    .
    |-- antora-playbook.yml
    |-- docs
    |   |-- antora.yml
    |   `-- modules
    |       `-- ROOT
    |           `-- pages
    |               `-- index.adoc
    |-- package-lock.json
    `-- package.json
    ```
    * 各セクションは別リポジトリで管理しても問題ない。

## Antoraとは
* Javaベースで実装されるサイト生成ツール。
* AsciiDoc形式のファイルを読み込み、ドキュメントを生成

## 特徴

### 🙆
* カスタマイズのバライティ多い。
* Versionで管理可能

### 🙅
* AsciiDocで各ファイルを作成する必要がある。tblsであれば、Markdown=>AsciiDocに、Schemaspyであれば、html=>AsciiDocに変換する必要あり?

## 参考文献
* [Antora Official Docs](https://antora.org/)
* [Antora Demo](https://gitlab.com/antora/demo)
* [Antora: ソフトウェア チームのためのドキュメント サイト (Dan Allen 著) in Youtube](https://www.youtube.com/watch?v=BAJ8F7yQz64)
* [Creating a documentation site for users with AsciiDoc and Antora (Alexander SCHWARTZ) in Youtube](https://www.youtube.com/watch?v=C-YT4KpMgNk)
* [Creating Documents in PDF and HTML format with Asciidoc, Antora, Asciidotor using VS Code.- Part1](https://www.youtube.com/watch?v=t_o2wKzQ9_o)
* [Antora Documentation](https://docs.antora.org/antora/latest/)
* [Antora で AsciiDoc 形式のドキュメントが保存されたレポジトリからドキュメントサイトを生成してみる](https://ksby.hatenablog.com/entry/2021/01/21/101651)
* [Good practice to write the version (= tag) in a file when tagging a Git repo with Github Actions](https://stackoverflow.com/questions/73562020/good-practice-to-write-the-version-tag-in-a-file-when-tagging-a-git-repo-wit)
* [AsciiDoc と Antora でマニュアルサイトを構築しました](https://webclass.jp/blog/2022/08/23/asciidoc-%E3%81%A8-antora-%E3%81%A7%E3%83%9E%E3%83%8B%E3%83%A5%E3%82%A2%E3%83%AB%E3%82%B5%E3%82%A4%E3%83%88%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%81%9F/)


[目次に戻る](#目次)


# Pandoc

## 参考文献
* [公式Doc](https://pandoc.org/MANUAL.html#extension-rebase_relative_paths)
* [asciidoc to markdown](https://qiita.com/yumechi/items/4124576d21e7242b878f)
* [【Obsidian】Pandocが画像のパスを正しく認識しない問題について](https://zenn.dev/hk_ilohas/articles/obsidian-pandoc-error)
* [Provide a way to specify multiple base path for finding images, like TEXINPUT in github issue](https://github.com/jgm/pandoc/issues/852)
* [Relative images are relative to working directory, not file #3752 in github issue](https://github.com/jgm/pandoc/issues/3752)
* [MarkdownをAsciidocに変換するKramdocまたはPandocをDocker環境で動かす](https://ossyaritoori.hatenablog.com/entry/2020/10/16/Docker%E7%92%B0%E5%A2%83%E3%81%A7Markdown%E3%82%92Asciidoc%E3%81%AB%E5%A4%89%E6%8F%9B%E3%81%99%E3%82%8BKramdoc%E3%82%92%E5%8B%95%E3%81%8B%E3%81%99)

[目次に戻る](#目次)



## 参考文献
タグ













https://copier.readthedocs.io/en/v5.0.0/


https://qiita.com/sky_y/items/80bcd0f353ef5b8980ee




pandoc tbls/dbdoc/attribute.md -f markdown -t asciidoc -o docs/modules/dbdoc/pages/attribute.adoc
