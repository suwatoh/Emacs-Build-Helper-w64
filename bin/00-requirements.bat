@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%

:7ZEXE
title Download 7z.exe
if exist 7z.exe goto 7ZDLL
call wgetfile https://7-zip.opensource.jp/howto/9.20/7z.exe %WORKDIR%\7z.exe
if not exist 7z.exe goto 7ZEXE

:7ZDLL
if exist 7z.dll goto MSYS2
title Download 7z.dll
call wgetfile https://7-zip.opensource.jp/howto/9.20/7z.dll %WORKDIR%\7z.dll
if not exist 7z.dll goto 7ZDLL

:MSYS2
if exist %MSYSINSTALLER% goto MSYS2SETUP
title Download MSYS2
call wgetfile http://repo.msys2.org/distrib/x86_64/%MSYSINSTALLER% %WORKDIR%\%MSYSINSTALLER%
if not exist %MSYSINSTALLER% goto MSYS2

:MSYS2SETUP
title Build Helper for Emacs 64bit on Windows
if not exist msys64 (7z x %MSYSINSTALLER% -so | 7z x -aoa -si -ttar)

pushd msys64

:: MSYS2初回起動
call msys2_shell %MSYS2SHELLPARAMS% -c "%MSYS2SHELLEND%"

:: MSYS2アップグレード
cls
echo 別ウィンドウが開きます。インストールの確認に「Y」と入力してください。
echo.
echo 更新を完了するために、この端末を含む全ての MSYS2 プロセスが閉じられます。続行しますか？ [Y/n]
echo のようなメッセージが出たら「Y」と入力して別ウィンドウを閉じてください。
call msys2_shell %MINTTYPARAMS% -c "pacman -Syuu"

:STANDBYFORMINTTY
tasklist | findstr "mintty.exe" > NUL
if not ERRORLEVEL 1 goto STANDBYFORMINTTY

call msys2_shell %MSYS2SHELLPARAMS% -c "%MSYS2SHELLEND%"

echo y | call msys2_shell %MSYS2SHELLPARAMS% -c "pacman -Syuu; %MSYS2SHELLEND%"

call msys2_shell %MSYS2SHELLPARAMS% "./needed-packages.sh"
call msys2_shell %MSYS2SHELLPARAMS% -c "%MSYS2SHELLEND%"

popd

popd
