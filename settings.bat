:: ��ƃt�H���_
set WORKDIR=%TEMP%\Emacs-Build-Helper

:: ZIP�t�@�C���̍쐬�ꏊ
set OUTPUTDIR=%USERPROFILE%\Desktop

:: MSYS2
set MSYSINSTALLER=msys2-base-x86_64-20230718.tar.xz

:: Emacs�o�[�W����
set EMACS_VER=emacs-29.1

:: IME�p�b�`��URL�i����`�̏ꍇ��IME�p�b�`��K�p���܂���j
REM set IMEPATCHURL=https://raw.githubusercontent.com/mhatta/emacs-27-x86_64-win-ime/master/emacs-27.1-windows-ime-20200914.patch

:: IME�p�b�`��p�I�v�V�����ɕt���鐔��
set IMEPATCHLEVEL=1

:: cmigemo-module��URL�i����`�̏ꍇ��cmigemo��emacs�ɑg�ݍ��݂܂���j
set CMIGEMOMODULEURL=https://github.com/rzl24ozi/cmigemo-module
set CMIGEMOURL=https://github.com/koron/cmigemo
set QKCURL=http://hp.vector.co.jp/authors/VA000501/qkcc100.zip

:: Emacs�̃r���h�I�v�V����
set EMACSCFLAGS=-O3 -march=native -static
set EMACSLDFLAGS=
set EMACSBUILDPARAMS=--without-dbus --host=x86_64-w64-mingw32

:: make�̃W���u��
set /a MAKEJOBS=NUMBER_OF_PROCESSORS

:: �C���X�g�[���i����`�ɂ��Ȃ����Ɓj
set MAKE_INSTALL=make install-strip

:: src�̃R�s�[��i����`�̏ꍇ�̓R�s�[���܂���j
set EMACSSRCDIR=

:: �N���[���A�b�v
set CLEANUP=yes
rem set CLEANUP=no

set MSYS2SYSTEM=mingw64
set MSYS2SHELLPARAMS=-%MSYS2SYSTEM% -defterm -where %WORKDIR% -no-start
set MINTTYPARAMS=-%MSYS2SYSTEM% -mintty
set MSYS2SHELLEND=ps -ef ^| grep '[?]' ^| awk '{print $2}' ^| xargs -r kill
