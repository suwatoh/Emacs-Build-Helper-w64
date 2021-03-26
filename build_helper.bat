@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

set PATH=
set PATH=%SystemRoot%\system32;C:\Windows\System32\WindowsPowerShell\v1.0

cd %~dp0
cls
color

:: �ݒ�ǂݍ���
call settings.bat

:: �h���C�u�̋󂫗e�ʂ��m�F
call utils\precheck %WORKDIR%

if %ERRORLEVEL%==1 (
echo ��ƃt�H���_���쐬����h���C�u�̋󂫗e�ʂ����Ȃ����܂��B
pause
exit
)

:: ��ƃf�B���N�g��������
if not exist %WORKDIR% goto MAKEWORKDIR
:FORCEDEL
cls
set /p FORCEDEL="��ƃt�H���_�͊��ɑ��݂��܂��B�폜���Ă悢�ł����H[Y/n] "
if /i "%FORCEDEL%"=="Y" (rd /s /q %WORKDIR% & goto MAKEWORKDIR)
if "%FORCEDEL%"=="" (rd /s /q %WORKDIR% & goto MAKEWORKDIR)
if /i "%FORCEDEL%"=="N" goto MAIN
goto FORCEDEL

:MAKEWORKDIR
md %WORKDIR%

:MAIN
if not exist %WORKDIR%\needed-packages.sh copy /y utils\needed-packages.sh %WORKDIR%\ >NUL
if not exist %WORKDIR%\wgetfile.bat copy /y utils\wgetfile.* %WORKDIR%\ >NUL

rem 7z�EMSYS2�E�r���h�ɕK�v�ȃp�b�P�[�W��p��
if exist %~dp0bin\00-requirements.bat call %~dp0bin\00-requirements.bat

rem �\�[�X�t�@�C���̃_�E�����[�h
if exist %~dp0bin\01-download-emacs-src.bat call %~dp0bin\01-download-emacs-src.bat

rem IME�p�b�`�̓K�p
if exist %~dp0bin\02-ime-patch.bat call %~dp0bin\02-ime-patch.bat

rem Emacs���r���h
if exist %~dp0bin\03-build-emacs.bat call %~dp0bin\03-build-emacs.bat

rem cmigemo-module�̒ǉ�
if exist %~dp0bin\06-cmigemo-module.bat call %~dp0bin\06-cmigemo-module.bat

rem �֘A�t�@�C���̒��o
if exist %~dp0bin\08-compress.bat call %~dp0bin\08-compress.bat

cd %~dp0

if "%CLEANUP%"=="yes" (echo Cleanup... & rd /s /q %WORKDIR%)
