@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

if not defined CMIGEMOMODULEURL goto :eof
if not defined CMIGEMOURL goto :eof
if not defined NKFURL goto :eof

pushd %WORKDIR%

title Download cmigemo-module

:DOWNLOAD1
if exist cmigemo-module-master.zip goto DOWNLOAD2
call wgetfile %CMIGEMOMODULEURL%/archive/master.zip %WORKDIR%\cmigemo-module-master.zip
if not exist cmigemo-module-master.zip goto DOWNLOAD1

:DOWNLOAD2
if exist cmigemo-master.zip goto DOWNLOAD3
call wgetfile %CMIGEMOURL%/archive/master.zip %WORKDIR%\cmigemo-master.zip
if not exist cmigemo-master.zip goto DOWNLOAD2

:DOWNLOAD3
if exist nkf-master.zip goto EXPAND
call wgetfile %NKFURL%/archive/master.zip %WORKDIR%\nkf-master.zip
if not exist nkf-master.zip goto DOWNLOAD3

:EXPAND
title Build Helper for Emacs 64bit on Windows
7z x cmigemo-module-master.zip *\Makefile *\cmigemo-module.c -o%EMACS_VER%\modules -y
7z x cmigemo-master.zip -y
7z x nkf-master.zip -y

::------------------------------------------------------------------------------------
:: �I���W�i����Make_mingw.mak��dllwrap�Ƃ����Â��c�[�����g�p���邽�߁A�G���[����������
:: cmigemo���C���X�g�[���ł��Ȃ��B
:: Gemini CLI�ɏC�����Ă������Make_mingw.mak�ɒu��������B
if exist Make_mingw.mak copy /y Make_mingw.mak cmigemo-master\compile\
::------------------------------------------------------------------------------------

:BUILD
pushd %WORKDIR%\msys64

set NKFBUILDCOMMAND="cd nkf-master; make; make install; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %NKFBUILDCOMMAND%

set BUILDCOMMAND1="cd cmigemo-master; ./configure; make mingw-all; make mingw-install; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %BUILDCOMMAND1%

set BUILDCOMMAND2="cd %EMACS_VER%/modules/cmigemo-module-master; make SO=dll; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %BUILDCOMMAND2%

popd

popd
