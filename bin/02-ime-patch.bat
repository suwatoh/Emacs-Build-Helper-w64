@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

if not defined IMEPATCHURL goto :eof

pushd %WORKDIR%

if exist ime-patched goto END

if exist emacs-ime.patch goto PATCH
:DOWNLOAD
title Download IME Patch
call wgetfile %IMEPATCHURL% %WORKDIR%\emacs-ime.patch
if not exist emacs-ime.patch goto DOWNLOAD

:PATCH
title Build Helper for Emacs 64bit on Windows

pushd msys64
set PATCHCOMMAND="patch -p%IMEPATCHLEVEL% -d %EMACS_VER% <./emacs-ime.patch"
call msys2_shell %MSYS2SHELLPARAMS% -c %PATCHCOMMAND%
if %ERRORLEVEL%==0 (set IMEPATCHED=1) else (set IMEPATCHED=)
call msys2_shell %MSYS2SHELLPARAMS% -c "%MSYS2SHELLEND%"
popd

if defined IMEPATCHED copy nul ime-patched /y

:END

popd
