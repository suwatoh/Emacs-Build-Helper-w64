:: 作業フォルダ
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIPファイルの作成場所
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20250830.tar.xz

:: Emacsバージョン
set EMACS_VER=emacs-30.2

:: cmigemo-moduleのURL（未定義の場合はcmigemoをemacsに組み込みません）
set CMIGEMOMODULEURL=https://github.com/rzl24ozi/cmigemo-module
set CMIGEMOURL=https://github.com/koron/cmigemo
set NKFURL=https://github.com/nurse/nkf

:: Emacsのビルドオプション
set EMACSCFLAGS=-O3 -march=native
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--host=x86_64-w64-mingw32 --without-compress-install --with-native-compilation=aot

:: 最小セット依存ファイル
set MINSETDEPENDENCIES=libwinpthread-*.dll libgmp-*.dll

:: TLS/SSL依存ファイル（最小セット以外なら必須扱い）
set GNUTLSDEPENDENCIES=libgnutls-*.dll libbrotlidec.dll libbrotlienc.dll libgcc_s_seh-*.dll libhogweed-*.dll libidn2-*.dll libintl-*.dll libnettle-*.dll libp11-kit-*.dll libtasn1-*.dll libunistring-*.dll zlib1.dll libzstd.dll libbrotlicommon.dll libiconv-*.dll libffi-*.dll

:: ネイティブコンパイル依存ファイル
set GCCJITDEPENDENCIES=libgccjit-*.dll libisl-*.dll libmpc-*.dll libmpfr-*.dll libstdc++-*.dll

:: XML/HTML解析依存ファイル
set MARKUPDEPENDENCIES=libxml2-*.dll liblzma-*.dll

:: オプション依存ファイル（SVGも利用するならlibpng16-*.dllが必要）
set OPTIONDEPENDENCIES=libbz2-*.dll libgif-*.dll libjpeg-*.dll libpng16-*.dll libsqlite3-*.dll libtree-sitter.dll libXpm-nox4.dll

:: SVG依存ファイル（上記の依存ファイルも必要）
set RSVGDEPENDENCIES=librsvg-2-*.dll libcairo-gobject-*.dll libcairo-*.dll libgdk_pixbuf-2.0-*.dll libgio-2.0-*.dll libglib-2.0-*.dll libgobject-2.0-*.dll libpango-1.0-*.dll libpangocairo-1.0-*.dll libfontconfig-*.dll libfreetype-*.dll libpixman-1-*.dll libgmodule-2.0-*.dll libpcre2-8-*.dll libfribidi-*.dll libharfbuzz-*.dll libthai-*.dll libdatrie-*.dll libpangoft2-1.0-*.dll libpangowin32-1.0-*.dll libexpat-*.dll

:: WebP画像依存ファイル
set WEBPDEPENDENCIES=libwebp-*.dll libsharpyuv-*.dll

:: makeのジョブ数
set /a MAKEJOBS=NUMBER_OF_PROCESSORS

:: インストール（未定義にしないこと）
set MAKE_INSTALL=make install-strip

:: クリーンアップ
set CLEANUP=yes
rem set CLEANUP=no

:: MSYS2用設定
set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
