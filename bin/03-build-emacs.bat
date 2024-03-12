@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%\msys64

if not defined EMACSCFLAGS goto BUILD

echo "%EMACSCFLAGS%" | %SystemRoot%\system32\find "-static" >NUL
if ERRORLEVEL 1 (set EMACSCFLAGS=%EMACSCFLAGS% -static)
set EMACSCFLAGS=CFLAGS='%EMACSCFLAGS%'

:BUILD
if defined EMACSLDFLAGS (set EMACSLDFLAGS=LDFLAGS='%EMACSLDFLAGS%') else (set EMACSLDFLAGS= )

set EMACSBUILD="cd %EMACS_VER%; ./autogen.sh; %EMACSCFLAGS% %EMACSLDFLAGS% ./configure %EMACSBUILDPARAMS%; make -j%MAKEJOBS%; %MAKE_INSTALL%; %MSYS2SHELLEND%"

call msys2_shell %MSYS2SHELLPARAMS% -c %EMACSBUILD%

popd
