
@echo off
setlocal EnableExtensions
title Instalador de OpenAI Codex para Windows
color 0A

echo ==========================================
echo   INSTALADOR AUTOMATICO DE OPENAI CODEX
echo ==========================================
echo.

:: Verificar permisos de administrador
fltmc >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Ejecuta este BAT como administrador.
    pause
    exit /b 1
)

:: Instalar Chocolatey
echo [1/5] Comprobando Chocolatey...
if not exist "%ProgramData%\chocolatey\bin\choco.exe" (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    if errorlevel 1 goto :error
)
set "PATH=%ProgramData%\chocolatey\bin;%PATH%"

where choco >nul 2>&1
if errorlevel 1 goto :error

:: Instalar Git
echo [2/5] Instalando Git...
choco install git -y --no-progress
if errorlevel 1 goto :error

:: Instalar Node.js
echo [3/5] Instalando Node.js LTS...
choco install nodejs-lts -y --no-progress
if errorlevel 1 goto :error

:: Instalar VS Code
echo [4/5] Instalando Visual Studio Code...
choco install vscode -y --no-progress
if errorlevel 1 goto :error

:: Actualizar PATH de la sesion
set "PATH=%ProgramFiles%\nodejs;%APPDATA%\npm;%PATH%"

:: Instalar Codex
echo [5/5] Instalando OpenAI Codex CLI...
where npm.cmd >nul 2>&1
if errorlevel 1 goto :error

call npm.cmd install -g @openai/codex
if errorlevel 1 goto :error

:: Verificar
echo.
echo ===== VERIFICACION =====
node --version
call npm.cmd --version
git --version
call codex.cmd --version
if errorlevel 1 goto :error

echo.
echo [OK] Instalacion terminada.
echo Abre una terminal normal y ejecuta:
echo codex login
pause
exit /b 0

:error
echo.
echo [ERROR] La instalacion no se completo.
pause
exit /b 1
  
