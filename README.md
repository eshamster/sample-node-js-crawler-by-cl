# 概要

書籍「JS+Node.jsによるWebクローラー/ネットエージェント」のサンプルコードをCommon Lisp（Parenscript）で書いてみるプロジェクトです。
    
# 前提ソフト

[Roswell](https://github.com/roswell/roswell)がインストールされていることを前提にしています。

また、拙作の[ps-experiment](https://github.com/eshamster/ps-experiment)を利用していますが、quicklispリポジトリには未登録であるため、quicklispから利用できる場所にcloneしておく必要があります。

```bash
$ cd ~/.roswell/local-projects
$ git clone https://github.com/eshamster/ps-experiment.git
```

# 使い方

1ファイルで完結するものに関しては以下の手順で利用できます（複数ファイルのものはまだ考えていません…）。

## init.rosでひな形を作成

以下の例では、`part02/download-node.lisp`が作られるため、これを編集します。

指定するディレクトリは事前に作成しておく必要があります。また、既存のファイルは上書きせず、エラーで終了します。

```bash
$ ./init.ros part02 download-node
```

## ひな形を編集

メインの処理は`main`関数内の`with-use-ps-pack`環境内に書くと良いです。関数定義等は`in-package`下で`defun.ps`などとして記述できます。

## run.rosで実行

下記例では、WORKディレクトリ配下に`WORK/download-node.js`を作成し、WORKディレクトリ配下でnode.jsから同JavaScriptファイルを実行します。

```bash
$ ./init.ros part02 download-node (引数)
```
