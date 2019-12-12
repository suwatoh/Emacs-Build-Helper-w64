:: 作業フォルダ
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIPファイルの作成場所
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20190524.tar.xz

:: Emacsバージョン
set EMACS_VER=emacs-26.3

:: IMEパッチのURL（未定義の場合はIMEパッチを適用しません）
set IMEPATCHURL=https://raw.githubusercontent.com/msnoigrs/emacs-on-windows-patches/master/00-emacs-26.3-w32-ime.patch

:: IMEパッチのpオプションに付ける数字
set IMEPATCHLEVEL=1

:: ImageMagickのバージョン（機能しないので未定義のままにしてください）
set IMAGEMAGICK_VER=

:: Emacsのビルドオプション
:: （IMAGEMAGICK_VERが未定義でない場合はEMACSBUILDPARAMSに--with-imagemagickが追加される）
set EMACSCFLAGS=-O2 -static
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--without-dbus --host=x86_64-w64-mingw32 --without-compress-install --with-modules

:: makeのジョブ数
set /a MAKEJOBS=NUMBER_OF_PROCESSORS/2

:: インストール（未定義にしないこと）
set MAKE_INSTALL=make install-strip

:: クリーンアップ
set CLEANUP=yes

set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
