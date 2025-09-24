@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%

set DESTINATION=%WORKDIR%\cab\%EMACS_VER%

:EXTRAC
set BINFILES=addpm.exe ctags.exe ebrowse.exe emacs-*.exe emacs.exe emacsclient.exe emacsclientw.exe etags.exe runemacs.exe

set DLLFILES=%MINSETDEPENDENCIES% %GNUTLSDEPENDENCIES% %GCCJITDEPENDENCIES% %MARKUPDEPENDENCIES% %OPTIONDEPENDENCIES% %RSVGDEPENDENCIES% %WEBPDEPENDENCIES%

set MANFILES=ctags.1.gz ebrowse.1.gz emacs.1.gz emacsclient.1.gz etags.1.gz

set ROBOCOPYOPTIONS=/ns /nc /nfl /ndl /np /njh /njs

if exist %DESTINATION% rd /s /q %DESTINATION%
robocopy msys64\mingw64\bin %DESTINATION%\bin %BINFILES% %DLLFILES% %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\include %DESTINATION%\include emacs-module.h %ROBOCOPYOPTIONS%
for /d %%D in (msys64\mingw64\lib\emacs*) do robocopy %%D %DESTINATION%\lib\emacs %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\lib\systemd\user %DESTINATION%\lib\systemd\user emacs.service %ROBOCOPYOPTIONS%

robocopy msys64\mingw64\libexec\emacs %DESTINATION%\libexec\emacs %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\share\applications %DESTINATION%\share\applications %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\share\emacs %DESTINATION%\share\emacs %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\share\icons %DESTINATION%\share\icons %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\share\info %DESTINATION%\share\info dir *.info %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\share\man\man1 %DESTINATION%\share\man\man1 %MANFILES% %ROBOCOPYOPTIONS% /s
robocopy msys64\mingw64\share\metainfo %DESTINATION%\share\metainfo %ROBOCOPYOPTIONS% /s

:: for cmigemo-module
if exist %EMACS_VER%\modules\cmigemo-module-master\cmigemo-module.dll (
7z x cmigemo-module-master.zip *\*.el -o%DESTINATION%\share\emacs\%EMACS_VER:~6%\site-lisp -y
robocopy %EMACS_VER%\modules\cmigemo-module-master %DESTINATION%\share\emacs\%EMACS_VER:~6%\site-lisp\cmigemo-module-master cmigemo-module.dll %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\share\migemo %DESTINATION%\share\emacs\%EMACS_VER:~6%\etc\migemo %ROBOCOPYOPTIONS% /s
robocopy msys64\usr\local\bin %DESTINATION%\bin migemo.dll %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\include %DESTINATION%\include migemo.h %ROBOCOPYOPTIONS%
robocopy msys64\usr\local\lib %DESTINATION%\lib libmigemo.dll.a %ROBOCOPYOPTIONS%
copy /y msys64\usr\local\doc\migemo\README_j.txt %DESTINATION%\share\emacs\%EMACS_VER:~6%\etc\migemo_README_j.txt
)

:: add gcc
:: https://misohena.jp/blog/2025-02-24-emacs-30-setup-on-ms-windows.html
echo %EMACSBUILDPARAMS% | %SystemRoot%\system32\find "--with-native-compilation" >NUL
if ERRORLEVEL 1 goto ZIP
set GCCJITBINFILES=as.exe ld.exe
set GCCJITLIBFILES=crtbegin.o crtend.o dllcrt2.o libadvapi32.a libgcc_s.a libkernel32.a libmingw32.a libmingwex.a libmoldname.a libmsvcrt.a libpthread.a libshell32.a libuser32.a
robocopy msys64\mingw64\bin %DESTINATION%\lib\gcc %GCCJITBINFILES% %ROBOCOPYOPTIONS%
robocopy msys64\mingw64\lib %DESTINATION%\lib\gcc %GCCJITLIBFILES% %ROBOCOPYOPTIONS%
for /d %%D in (msys64\mingw64\lib\gcc\x86_64-w64-mingw32\*) do robocopy %%D %DESTINATION%\lib\gcc libgcc.a %ROBOCOPYOPTIONS%

:ZIP
if not exist %DESTINATION% goto END

if exist ime-patched (set IMEPATCHED=1) else (set IMEPATCHED=)

pushd %DESTINATION%
cd ..
set FMTDATE=%DATE:/=%
set FMTDATE=%FMTDATE:~,8%
set ZIPFILENAME=%OUTPUTDIR%\%EMACS_VER%-x86_64
set ZIPFILENAME=%ZIPFILENAME%-%FMTDATE%.zip
if exist "%ZIPFILENAME%" del /f "%ZIPFILENAME%"
%WORKDIR%\7z a -r -tzip "%ZIPFILENAME%" %EMACS_VER%
popd

:END

popd
