:: ��ƃt�H���_
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIP�t�@�C���̍쐬�ꏊ
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20250830.tar.xz

:: Emacs�o�[�W����
set EMACS_VER=emacs-30.2

:: cmigemo-module��URL�i����`�̏ꍇ��cmigemo��emacs�ɑg�ݍ��݂܂���j
set CMIGEMOMODULEURL=https://github.com/rzl24ozi/cmigemo-module
set CMIGEMOURL=https://github.com/koron/cmigemo
set NKFURL=https://github.com/nurse/nkf

:: Emacs�̃r���h�I�v�V����
set EMACSCFLAGS=-O3 -march=native
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--host=x86_64-w64-mingw32 --without-compress-install --with-native-compilation=aot

:: �ŏ��Z�b�g�ˑ��t�@�C��
set MINSETDEPENDENCIES=libwinpthread-*.dll libgmp-*.dll

:: TLS/SSL�ˑ��t�@�C���i�ŏ��Z�b�g�ȊO�Ȃ�K�{�����j
set GNUTLSDEPENDENCIES=libgnutls-*.dll libbrotlidec.dll libbrotlienc.dll libgcc_s_seh-*.dll libhogweed-*.dll libidn2-*.dll libintl-*.dll libnettle-*.dll libp11-kit-*.dll libtasn1-*.dll libunistring-*.dll zlib1.dll libzstd.dll libbrotlicommon.dll libiconv-*.dll libffi-*.dll

:: �l�C�e�B�u�R���p�C���ˑ��t�@�C��
set GCCJITDEPENDENCIES=libgccjit-*.dll libisl-*.dll libmpc-*.dll libmpfr-*.dll libstdc++-*.dll

:: XML/HTML��͈ˑ��t�@�C��
set MARKUPDEPENDENCIES=libxml2-*.dll liblzma-*.dll

:: �I�v�V�����ˑ��t�@�C���iSVG�����p����Ȃ�libpng16-*.dll���K�v�j
set OPTIONDEPENDENCIES=libbz2-*.dll libgif-*.dll libjpeg-*.dll libpng16-*.dll libsqlite3-*.dll libtree-sitter.dll libXpm-nox4.dll

:: SVG�ˑ��t�@�C���i��L�̈ˑ��t�@�C�����K�v�j
set RSVGDEPENDENCIES=librsvg-2-*.dll libcairo-gobject-*.dll libcairo-*.dll libgdk_pixbuf-2.0-*.dll libgio-2.0-*.dll libglib-2.0-*.dll libgobject-2.0-*.dll libpango-1.0-*.dll libpangocairo-1.0-*.dll libfontconfig-*.dll libfreetype-*.dll libpixman-1-*.dll libgmodule-2.0-*.dll libpcre2-8-*.dll libfribidi-*.dll libharfbuzz-*.dll libthai-*.dll libdatrie-*.dll libpangoft2-1.0-*.dll libpangowin32-1.0-*.dll libexpat-*.dll

:: WebP�摜�ˑ��t�@�C��
set WEBPDEPENDENCIES=libwebp-*.dll libsharpyuv-*.dll

:: make�̃W���u��
set /a MAKEJOBS=NUMBER_OF_PROCESSORS

:: �C���X�g�[���i����`�ɂ��Ȃ����Ɓj
set MAKE_INSTALL=make install-strip

:: �N���[���A�b�v
set CLEANUP=yes
rem set CLEANUP=no

:: MSYS2�p�ݒ�
set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
