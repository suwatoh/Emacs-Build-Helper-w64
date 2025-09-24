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
if /i "%FORCEDEL%"=="Y" goto DELWORKDIR
if    "%FORCEDEL%"==""  goto DELWORKDIR
if /i "%FORCEDEL%"=="N" goto MAIN
goto FORCEDEL

:DELWORKDIR
rd /s /q %WORKDIR%

:MAKEWORKDIR
md %WORKDIR%

:MAIN
:: precheck.*�ȊO����ƃt�H���_�ɃR�s�[
for %%I in (utils\*) do if /i %%~nI neq precheck copy /y %%I %WORKDIR%\ >NUL

:: 7z�EMSYS2�E�r���h�ɕK�v�ȃp�b�P�[�W��p��
call :EXECIF %~dp0bin\01-requirements.bat

:: �\�[�X�t�@�C���̃_�E�����[�h
call :EXECIF %~dp0bin\02-download-emacs-src.bat

:: Emacs���r���h
call :EXECIF %~dp0bin\03-build-emacs.bat

:: cmigemo-module�̒ǉ�
call :EXECIF %~dp0bin\04-cmigemo-module.bat

:: �֘A�t�@�C���̒��o
call :EXECIF %~dp0bin\05-compress.bat

cd %~dp0

if "%CLEANUP%"=="yes" (echo Cleanup... & rd /s /q %WORKDIR%)

goto :EOF


::------------------------------------------------------------------------------------
:EXECIF
if exist %1 call %1
goto :EOF
::------------------------------------------------------------------------------------
