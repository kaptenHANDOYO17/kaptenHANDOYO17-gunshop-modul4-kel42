@echo off
setlocal
cd /d "%~dp0"
title Langkah 1 - Install
set "PATH=%ProgramFiles%\nodejs;%ProgramFiles%\Git\cmd;%PATH%"

echo ==========================================================
echo    LANGKAH 1 : INSTALL  (cukup sekali saja)
echo ==========================================================
echo.

echo [1/3] Mengecek Node.js ...
call :cek_node
if not errorlevel 1 goto node_ok

echo Node.js belum ada atau versinya terlalu lama.
echo Memasang Node.js LTS otomatis ...
echo Kalau muncul jendela "Do you want to allow this app..." klik YES.
echo.
where winget >nul 2>nul
if errorlevel 1 goto manual_node
winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
winget upgrade -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements >nul 2>nul
call :cek_node
if errorlevel 1 goto manual_node

:node_ok
for /f "delims=" %%v in ('node -v') do echo       OK - Node.js %%v
echo.

echo [2/3] Mengecek Git ...
where git >nul 2>nul
if not errorlevel 1 goto git_ok
echo Git belum ada. Memasang Git otomatis ...
where winget >nul 2>nul
if errorlevel 1 goto git_skip
winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements
where git >nul 2>nul
if not errorlevel 1 goto git_ok
:git_skip
echo       Git belum berhasil dipasang. Tidak apa-apa untuk sekarang,
echo       Git baru dipakai di langkah 4. Download manual: https://git-scm.com/download/win
goto npm_install
:git_ok
echo       OK - Git sudah ada

:npm_install
echo.
echo [3/3] Mengunduh library proyek (npm install). Tunggu 1-3 menit ...
echo.
call npm install
if errorlevel 1 goto npm_gagal

echo.
echo ==========================================================
echo    SELESAI. Install berhasil.
echo    Sekarang double-click file  2-JALANKAN.bat
echo ==========================================================
echo.
pause
exit /b 0

:npm_gagal
echo.
echo GAGAL saat npm install. Cek koneksi internet, lalu double-click
echo 1-INSTALL.bat sekali lagi. Kalau tetap gagal, restart laptop dulu.
pause
exit /b 1

:manual_node
echo.
echo Node.js tidak bisa dipasang otomatis.
echo Browser akan membuka halaman download Node.js:
echo   1. Klik tombol download "Windows Installer (.msi)"
echo   2. Buka file yang terdownload, klik Next terus sampai Finish
echo   3. Double-click lagi file 1-INSTALL.bat ini
start "" https://nodejs.org/en/download
echo.
pause
exit /b 1

:cek_node
where node >nul 2>nul
if errorlevel 1 exit /b 1
node -e "const v=process.versions.node.split('.').map(Number);process.exit((v[0]===20&&v[1]>=19)||(v[0]===22&&v[1]>=12)||v[0]>=23?0:1)"
exit /b %errorlevel%
