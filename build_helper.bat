@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Build Helper for Emacs 64bit on Windows

set PATH=
set PATH=%SystemRoot%\system32;C:\Windows\System32\WindowsPowerShell\v1.0

cd %~dp0
cls
color

:: 設定読み込み
call settings.bat

:: ドライブの空き容量を確認
call utils\precheck %WORKDIR%

if %ERRORLEVEL%==1 (
echo 作業フォルダを作成するドライブの空き容量が少なすぎます。
pause
exit
)

:: 作業ディレクトリを準備
if not exist %WORKDIR% goto MAKEWORKDIR

:FORCEDEL
cls
set /p FORCEDEL="作業フォルダは既に存在します。削除してよいですか？[Y/n] "
if /i "%FORCEDEL%"=="Y" goto DELWORKDIR
if    "%FORCEDEL%"==""  goto DELWORKDIR
if /i "%FORCEDEL%"=="N" goto MAIN
goto FORCEDEL

:DELWORKDIR
rd /s /q %WORKDIR%

:MAKEWORKDIR
md %WORKDIR%

:MAIN
:: precheck.*以外を作業フォルダにコピー
for %%I in (utils\*) do if /i %%~nI neq precheck copy /y %%I %WORKDIR%\ >NUL

:: 7z・MSYS2・ビルドに必要なパッケージを用意
call :EXECIF %~dp0bin\01-requirements.bat

:: ソースファイルのダウンロード
call :EXECIF %~dp0bin\02-download-emacs-src.bat

:: Emacsをビルド
call :EXECIF %~dp0bin\03-build-emacs.bat

:: cmigemo-moduleの追加
call :EXECIF %~dp0bin\04-cmigemo-module.bat

:: 関連ファイルの抽出
call :EXECIF %~dp0bin\05-compress.bat

cd %~dp0

if "%CLEANUP%"=="yes" (echo Cleanup... & rd /s /q %WORKDIR%)

goto :EOF


::------------------------------------------------------------------------------------
:EXECIF
if exist %1 call %1
goto :EOF
::------------------------------------------------------------------------------------
