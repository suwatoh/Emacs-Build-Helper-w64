:: ��ƃt�H���_
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIP�t�@�C���̍쐬�ꏊ
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20190524.tar.xz

:: Emacs�o�[�W����
set EMACS_VER=emacs-26.3

:: IME�p�b�`��URL�i����`�̏ꍇ��IME�p�b�`��K�p���܂���j
set IMEPATCHURL=https://raw.githubusercontent.com/msnoigrs/emacs-on-windows-patches/master/00-emacs-26.3-w32-ime.patch

:: IME�p�b�`��p�I�v�V�����ɕt���鐔��
set IMEPATCHLEVEL=1

:: ImageMagick�̃o�[�W�����i�@�\���Ȃ��̂Ŗ���`�̂܂܂ɂ��Ă��������j
set IMAGEMAGICK_VER=

:: Emacs�̃r���h�I�v�V����
:: �iIMAGEMAGICK_VER������`�łȂ��ꍇ��EMACSBUILDPARAMS��--with-imagemagick���ǉ������j
set EMACSCFLAGS=-O2 -static
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--without-dbus --host=x86_64-w64-mingw32 --without-compress-install --with-modules

:: make�̃W���u��
set /a MAKEJOBS=NUMBER_OF_PROCESSORS/2

:: �C���X�g�[���i����`�ɂ��Ȃ����Ɓj
set MAKE_INSTALL=make install-strip

:: �N���[���A�b�v
set CLEANUP=yes

set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
