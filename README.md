# 概要
ブログ管理用リポジトリ

## 環境構築

```
brew install pandoc
```


## html生成

```
pandoc -f markdown -t html --template=mytemplate ./md/xxx.md > ./docs/xxx.html
```

## indexファイルの更新

```
bundle exec ruby crawler.rb
```
で情報取得して、mdにリスト追加して

```
pandoc -f markdown -t html --template=mytemplate ./md/index.md > ./docs/index.html
```
を実行