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
if /i "%FORCEDEL%"=="Y" (rd /s /q %WORKDIR% & goto MAKEWORKDIR)
if "%FORCEDEL%"=="" (rd /s /q %WORKDIR% & goto MAKEWORKDIR)
if /i "%FORCEDEL%"=="N" goto MAIN
goto FORCEDEL

:MAKEWORKDIR
md %WORKDIR%

:MAIN
if not exist %WORKDIR%\needed-packages.sh copy /y utils\needed-packages.sh %WORKDIR%\ >NUL
if not exist %WORKDIR%\wgetfile.bat copy /y utils\wgetfile.* %WORKDIR%\ >NUL

rem 7z・MSYS2・ビルドに必要なパッケージを用意
if exist %~dp0bin\00-requirements.bat call %~dp0bin\00-requirements.bat

rem ソースファイルのダウンロード
if exist %~dp0bin\01-download-emacs-src.bat call %~dp0bin\01-download-emacs-src.bat

rem IMEパッチの適用
if exist %~dp0bin\02-ime-patch.bat call %~dp0bin\02-ime-patch.bat

rem Emacsをビルド
if exist %~dp0bin\03-build-emacs.bat call %~dp0bin\03-build-emacs.bat

rem cmigemo-moduleの追加
if exist %~dp0bin\06-cmigemo-module.bat call %~dp0bin\06-cmigemo-module.bat

rem 関連ファイルの抽出
if exist %~dp0bin\08-compress.bat call %~dp0bin\08-compress.bat

cd %~dp0

if "%CLEANUP%"=="yes" (echo Cleanup... & rd /s /q %WORKDIR%)
