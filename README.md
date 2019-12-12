# Windows用64bit版Emacs26.3のビルドを支援するツール

## 概要

MSYS2のダウンロードから64bit版Emacs26.3のビルドまでをサポートするツールです。主な特色は次のとおりです。

  * 既存の環境を汚すことなくEmacs26.3のビルドができます。
  * IMEパッチを適用します。
  * Emacs26.3関連ファイルをまとめたZIPファイルを作成します。

Emacsのインストールは行いません。ZIPファイルを展開すればEmacsを使えるようになります。

## ビルド方法

### 1. 動作環境

  * OS: Windows 10 64bit
  * ハードディスク: 4GB以上の空き容量
  * ネットワーク環境: インターネットに接続する環境。プロキシ経由の場合には対応していません。

### 2. 設定

`settings.bat`は設定ファイルです。

`WORKDIR`の設定で作業フォルダの作成場所を変更できます。デフォルトではTEMPフォルダ内に作業フォルダを作成します。

`IMEPATCHURL`の設定でIMEパッチを入手するURLを変更できます。デフォルトでは[Masanao Igarashiさんが公開しているもの](https://github.com/msnoigrs/emacs-on-windows-patches)を使わせていただきました。公開ありがとうございます。`IMEPATCHURL`にURLの指定がない場合は、IMEパッチを適用しません。

### 3. ビルド

`build_helper.bat`を実行してください。直ちにMSYS2のファイルがダウンロードされ、MSYS2/MinGWの更新が始まります。途中、別ウィンドウが開いて

警告: terminate MSYS2 without returning to shell and check for updates again  
警告: for example close your terminal window instead of calling exit

のようなメッセージが出たら別ウィンドウを<kbd>Alt</kbd>+<kbd>F4</kbd>で終了してください。

いくつか確認のための入力を要求されますが、すべて<kbd>Enter</kbd>の入力でよいです。

Emacsのビルド完了まで（通信環境やマシンスペックによりますが）1時間程度かかります。気長に待ちましょう。

### 4. ZIPファイルの作成

ビルド完了後、デスクトップに`emacs-26.3-x86_64-ime-日付.zip`のような名前のファイルが作成されます。IMEパッチが適用されていないときには、ファイル名に`-ime`は付きません。

ZIPファイルにはEmacs関連ファイルのみ含まれます。手元で作成したものが素のWindows10（Windowsサンドボックス）で動作することを確認しています。

## IMEパッチについて

Emacs 26.2以降は公式ビルドでもIME経由でのインライン入力が可能になりました。さらにIMEパッチを適用したものなら、カーソルやモードラインやミニバッファにIME関連の設定ができたり、IME有効時のキー入力（<kbd>Ctrl</kbd>+<kbd>N</kbd>など）をEmacsが横取りしてしまう問題が解決されます。ただし、IMEパッチを適用したEmacsは突然落ちることがあります。注意してください。

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

となります。公式ビルドとの違いは、`--with-modules`を加えているのと、`CFLAGS`に`-g3`を付けないことです。また、`make install-strip`を使います。これより、ビルドしたEmacsのファイルはデバッグ情報が付加されないものとなります。

## ImageMagickについて

ImageMagickの組み込みには対応していません。

## ライセンス

[CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/deed) とします。
