@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

if not defined CMIGEMOMODULEURL goto :eof
if not defined CMIGEMOURL goto :eof
if not defined QKCURL goto :eof

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
if exist qkc.zip goto EXPAND
call wgetfile %QKCURL% %WORKDIR%\qkc.zip
if not exist qkc.zip goto DOWNLOAD3

:EXPAND
title Build Helper for Emacs 64bit on Windows
7z x cmigemo-module-master.zip *\Makefile *\cmigemo-module.c -o%EMACS_VER%\modules -y
7z x cmigemo-master.zip -y
7z x qkc.zip -oqkc -y

:BUILD
pushd %WORKDIR%\msys64

set QKCBUILDCOMMAND="cd qkc; make; mkdir /usr/local/bin; cp qkc.exe /usr/local/bin; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %QKCBUILDCOMMAND%

set BUILDCOMMAND1="cd cmigemo-master; ./configure; make mingw-all; make mingw-install; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %BUILDCOMMAND1%

set BUILDCOMMAND2="cd %EMACS_VER%/modules/cmigemo-module-master; make SO=dll; %MSYS2SHELLEND%"
call msys2_shell %MSYS2SHELLPARAMS% -c %BUILDCOMMAND2%

popd

popd
