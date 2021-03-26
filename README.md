# Windows用64bit版Emacs27.2のビルドを支援するツール

## 概要

MSYS2のダウンロードから64bit版Emacs27.2のビルドまでをサポートするツールです。主な特色は次のとおりです。

  * 既存の環境を汚すことなくEmacs27.2のビルドができます。
  * cmigemo-moduleを組み込みます。
  * Emacs27.2関連ファイルのみをまとめたZIPファイルを作成します。

Emacsのインストールは行いません。ZIPファイルを展開すればEmacsを使えるようになります。

## ビルド方法

### 1. 動作環境

  * OS: Windows 10 64bit
  * ハードディスク: 4GB以上の空き容量
  * ネットワーク環境: インターネットに接続する環境。プロキシ経由の場合には対応していません。

### 2. 設定

`settings.bat`は設定ファイルです。

`WORKDIR`の設定で作業フォルダの作成場所を変更できます。デフォルトではTEMPフォルダ内に作業フォルダを作成します。

### 3. ビルド

`build_helper.bat`を実行してください。直ちにMSYS2のファイルがダウンロードされ、MSYS2/MinGWの更新が始まります。いくつか確認のための入力を要求されますが、すべて<kbd>Enter</kbd>の入力でよいです。

Emacsのビルド完了まで（通信環境やマシンスペックによりますが）1時間程度かかります。気長に待ちましょう。

### 4. ZIPファイルの作成

ビルド完了後、デスクトップに`emacs-27.2-x86_64-ime-日付.zip`のような名前のファイルが作成されます。IMEパッチが適用されていないときには、ファイル名に`-ime`は付きません。

ZIPファイルにはEmacs関連ファイルとEmacsソースツリーのsrc/内のファイルのみ含まれます。公式ビルドにはEmacsの動作に直接には関係しないMSYS2/MinGWのファイルが多数含まれる一方、src/内のファイルは含まれていません。`EMACSSRCDIR`の設定を未定義にするとZIPファイルにsrc/内のファイルが含まれなくなります。

## IMEパッチについて

`IMEPATCHURL`の設定でIMEパッチのURLを指定すると、IMEパッチを適用することができます。しかしながら、現在は[tr-emacs-ime-module](https://github.com/trueroad/tr-emacs-ime-module)を利用するほうがよいでしょう。`IMEPATCHURL`にURLの指定がない場合は、IMEパッチを適用しません。

## ビルドされるEmacsについて

変数`system-configuration-features`の値は

``` text
"XPM JPEG TIFF GIF PNG RSVG SOUND NOTIFY ACL GNUTLS LIBXML2 ZLIB TOOLKIT_SCROLL_BARS MODULES THREADS LCMS2 W32_IME"
```

となります。

変数`system-configuration-options`の値は

``` text
"--without-dbus --host=x86_64-w64-mingw32 --without-compress-install --with-modules 'CFLAGS=-O2 -static'"
```

となります。また、`make install-strip`を使います。これより、ビルドしたEmacsのファイルはデバッグ情報が付加されないものとなります。

## cmigemo-moduleについて

デフォルト設定のとき、rzl24oziさんの[cmigemo-module](https://github.com/rzl24ozi/cmigemo-module)をダウンロードして、ビルドします。ZIPファイルにはcmigemo-module関連ファイルも含まれています。MELPAから`migemo.el`をインストールし、`init.el`に次の一行を書き加えてEmacsを起動すれば、migemoのインクリメンタル検索ができます。

``` emacs-lisp
(load-library "cmigemo")
```

## ライセンス

[CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/deed) とします。
