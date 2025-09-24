@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%

:DOWNLOAD
if exist %EMACS_VER%.tar.xz goto EXPAND
title Download Emacs Source
call wgetfile http://ftp.jaist.ac.jp/pub/GNU/emacs/%EMACS_VER%.tar.xz %WORKDIR%\%EMACS_VER%.tar.xz
if not exist %EMACS_VER%.tar.xz goto DOWNLOAD

:EXPAND
title Build Helper for Emacs 64bit on Windows
if not exist %EMACS_VER% (7z x %EMACS_VER%.tar.xz -so | 7z x -aoa -si -ttar)

popd
