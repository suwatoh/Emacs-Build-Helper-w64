:: 作業フォルダ
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIPファイルの作成場所
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20230718.tar.xz

:: Emacsバージョン
set EMACS_VER=emacs-29.1

:: IMEパッチのURL（未定義の場合はIMEパッチを適用しません）
REM set IMEPATCHURL=https://raw.githubusercontent.com/mhatta/emacs-27-x86_64-win-ime/master/emacs-27.1-windows-ime-20200914.patch

:: IMEパッチのpオプションに付ける数字
set IMEPATCHLEVEL=1

:: cmigemo-moduleのURL（未定義の場合はcmigemoをemacsに組み込みません）
set CMIGEMOMODULEURL=https://github.com/rzl24ozi/cmigemo-module
set CMIGEMOURL=https://github.com/koron/cmigemo
set QKCURL=http://hp.vector.co.jp/authors/VA000501/qkcc100.zip

:: Emacsのビルドオプション
set EMACSCFLAGS=-O3 -march=native -static
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--without-dbus --host=x86_64-w64-mingw32

:: makeのジョブ数
set /a MAKEJOBS=NUMBER_OF_PROCESSORS

:: インストール（未定義にしないこと）
set MAKE_INSTALL=make install-strip

:: srcのコピー先（未定義の場合はコピーしません）
set EMACSSRCDIR=

:: クリーンアップ
set CLEANUP=yes
rem set CLEANUP=no

set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
