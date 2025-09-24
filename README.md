# Windows用64bit版Emacs30.2のビルドを支援するツール

## 概要

MSYS2のダウンロードから64bit版Emacs30.2のビルドまでをサポートするツールです。主な特色は次のとおりです。

  * ローカルの環境を汚すことなくEmacs30.2のビルドができます。
  * ネイティブコンパイル機能を組み込みます。
  * cmigemo-moduleを組み込みます。
  * Emacs30.2関連ファイルをまとめたZIPファイルを作成します。

Emacsのインストールは行いません。ZIPファイルを展開すればEmacsを使えるようになります。

## ビルド方法

### 1. 動作環境

  * OS: Windows 11 24H2
  * ハードディスク: 6GB以上の空き容量
  * ネットワーク環境: インターネットに接続する環境

### 2. リポジトリの準備

リポジトリをローカルにクローンしてください。その際に、**Gitの自動改行コード変換（autocrlf）はtrueにしてください**。デフォルトではtrueになっています。

グローバル設定は、以下のコマンドで確認できます。

``` shell
git config --global core.autocrlf
```

### 3. 設定

`settings.bat`は設定ファイルです。

`WORKDIR`の設定で作業フォルダの作成場所を変更できます。デフォルトではTEMPフォルダ内に作業フォルダを作成します。

### 4. ビルド

`build_helper.bat`を実行してください。直ちにMSYS2のファイルがダウンロードされ、MSYS2/MinGWの更新が始まります。いくつか確認のための入力を要求されますが、すべて<kbd>Enter</kbd>の入力でよいです。

Emacsのビルド完了まで（通信環境やマシンスペックによりますが）30分程度かかります。気長に待ちましょう。

mirror.msys2.orgが不安定で、必要なパッケージの取得に失敗して、ビルドできないことがあります。その場合は、数時間または数日おいてから再実行してください。

### 5. ZIPファイルの作成

ビルド完了後、デスクトップに`emacs-30.2-x86_64-日付.zip`のような名前のファイルが作成されます。

ZIPファイルに含まれるファイルのうち、依存ファイル（.dll）は[Dependencies](https://github.com/lucasg/Dependencies)で調査しました。使用しない機能があれば、依存ファイルを削減することもできます。詳しくは、設定ファイルを見てください。

## 6. ビルドされるEmacsについて

変数`system-configuration-features`の値は

``` text
"ACL GIF GMP GNUTLS HARFBUZZ JPEG LCMS2 LIBXML2 MODULES NATIVE_COMP NOTIFY W32NOTIFY PDUMPER PNG RSVG SOUND SQLITE3 THREADS TIFF TOOLKIT_SCROLL_BARS TREE_SITTER WEBP XPM ZLIB"
```

となります。

変数`system-configuration-options`の値は

``` text
"--host=x86_64-w64-mingw32 --without-compress-install --with-native-compilation=aot 'CFLAGS=-O3 -march=native'"
```

となります。これらの値は、`EMACSCFLAGS`や`EMACSLDFLAGS`、`EMACSBUILDPARAMS`の設定で変わります。

また、`make install-strip`を使います。これより、ビルドしたEmacsのファイルはデバッグ情報が付加されないものとなります。

## 7. cmigemo-moduleについて

デフォルト設定のとき、rzl24oziさんの[cmigemo-module](https://github.com/rzl24ozi/cmigemo-module)をダウンロードして、ビルドします。ZIPファイルにはcmigemo-module関連ファイルも含まれています。MELPAから`migemo.el`をインストールし、`init.el`に次の一行を書き加えてEmacsを起動すれば、migemoのインクリメンタル検索ができます。

``` emacs-lisp
(load-library "cmigemo")
```

## 8. ライセンス

[CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/deed) とします。
