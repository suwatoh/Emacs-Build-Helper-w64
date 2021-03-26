@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%

set DESTINATION=%WORKDIR%\cab\%EMACS_VER%

set BINFILES=addpm.exe ctags.exe ebrowse.exe emacs-*.exe emacs.exe emacsclient.exe emacsclientw.exe etags.exe runemacs.exe

set DLLFILES=libXpm-noX4.dll libbz2-*.dll libcairo-?.dll libcroco-*.dll libexpat-*.dll libffi-*.dll libfontconfig-*.dll libfreetype-*.dll libfribidi-*.dll libgcc_s_seh-*.dll libgdk_pixbuf-*.dll libgif-*.dll libgio-*.dll libglib-*.dll libgmodule-*.dll libgmp-*.dll libgnutls-*.dll libgobject-*.dll libgraphite2.dll libharfbuzz-?.dll libhogweed-*.dll libiconv-*.dll libidn2-*.dll libintl-*.dll libjansson-*.dll libjpeg-*.dll liblcms2-*.dll liblzma-*.dll libnettle-*.dll libp11-kit-*.dll libpango-*.dll libpangocairo-*.dll libpangoft2-*.dll libpangowin32-*.dll libpcre-*.dll libpixman-?-*.dll libpng16-*.dll librsvg-?-*.dll libstdc++-*.dll libtasn1-*.dll libtiff-*.dll libunistring-*.dll libwinpthread-*.dll libxml2-*.dll zlib1.dll

set MANFILES=ctags.1 ebrowse.1 emacs.1 emacsclient.1 etags.1

set ROBOCOPYOPTIONS=/s /ns /nc /nfl /ndl /np /njh /njs

if exist %DESTINATION% rd /s /q %DESTINATION%
robocopy msys64\mingw64\bin %DESTINATION%\bin %BINFILES% %DLLFILES% %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\include %DESTINATION%\include emacs-module.h %ROBOCOPYOPTIONS%
REM robocopy msys64\mingw64\lib\systemd\user %DESTINATION%\lib\systemd\user emacs.service %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\libexec\emacs %DESTINATION%\libexec\emacs %ROBOCOPYOPTIONS%
REM robocopy msys64\mingw64\share\applications %DESTINATION%\share\applications %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\share\emacs %DESTINATION%\share\emacs %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\share\icons %DESTINATION%\share\icons %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\share\info %DESTINATION%\share\info dir *.info %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\share\man\man1 %DESTINATION%\share\man\man1 %MANFILES% %ROBOCOPYOPTIONS%
REM robocopy msys64\mingw64\share\metainfo %DESTINATION%\share\metainfo %ROBOCOPYOPTIONS%

:: add src
if defined EMACSSRCDIR (robocopy %EMACS_VER%\src %DESTINATION%\%EMACSSRCDIR% %ROBOCOPYOPTIONS%)

:: for cmigemo-module
if exist %EMACS_VER%\modules\cmigemo-module-master\cmigemo-module.dll (
7z x cmigemo-module-master.zip *\*.el -o%DESTINATION%\share\emacs\%EMACS_VER:~6%\site-lisp -y
robocopy %EMACS_VER%\modules\cmigemo-module-master %DESTINATION%\share\emacs\%EMACS_VER:~6%\site-lisp\cmigemo-module-master cmigemo-module.dll %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\share\migemo %DESTINATION%\share\emacs\%EMACS_VER:~6%\etc\migemo %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\bin %DESTINATION%\bin migemo.dll %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\include %DESTINATION%\include migemo.h %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\lib %DESTINATION%\lib libmigemo.dll.a %ROBOCOPYOPTIONS%
copy /y msys64\usr\local\doc\migemo\README_j.txt %DESTINATION%\share\emacs\%EMACS_VER:~6%\etc\migemo_README_j.txt
)

:ZIP
if not exist %DESTINATION% goto END

if exist ime-patched (set IMEPATCHED=1) else (set IMEPATCHED=)

pushd %DESTINATION%
cd ..
set ZIPFILENAME=%OUTPUTDIR%\%EMACS_VER%-x86_64
if defined IMEPATCHED set ZIPFILENAME=%ZIPFILENAME%-ime
if defined IMAGEMAGICK_VER set ZIPFILENAME=%ZIPFILENAME%-imagemagick
set ZIPFILENAME=%ZIPFILENAME%-%DATE:/=%.zip
if exist %ZIPFILENAME% del /f %ZIPFILENAME%
%WORKDIR%\7z a -r -tzip %ZIPFILENAME% %EMACS_VER%
popd

:END

popd
