@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

pushd %WORKDIR%

:7ZEXE
if exist 7z.exe goto 7ZDLL
title Download 7z.exe
call wgetfile https://sevenzip.osdn.jp/howto/9.20/7z.exe %WORKDIR%\7z.exe
if not exist 7z.exe goto 7ZEXE

:7ZDLL
if exist 7z.dll goto MSYS2
title Download 7z.dll
call wgetfile https://sevenzip.osdn.jp/howto/9.20/7z.dll %WORKDIR%\7z.dll
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

:: MSYS2����N��
call msys2_shell %MSYS2SHELLPARAMS% -c "%MSYS2SHELLEND%"

:: MSYS2�A�b�v�O���[�h
cls
echo �ʃE�B���h�E���J���܂��B�C���X�g�[���̊m�F�ɁuY�v�Ɠ��͂��Ă��������B
echo �x��: terminate MSYS2 without returning to shell and check for updates again
echo �x��: for example close your terminal window instead of calling exit
echo �̂悤�ȃ��b�Z�[�W���o����ʃE�B���h�E�� Alt+F4 �ŕ��Ă��������B
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
