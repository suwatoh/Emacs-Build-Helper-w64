@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

cd %~dp0

cls
powershell -NoProfile -ExecutionPolicy Unrestricted .\%~n0.ps1 %1
cls

exit /b %ERRORLEVEL%
