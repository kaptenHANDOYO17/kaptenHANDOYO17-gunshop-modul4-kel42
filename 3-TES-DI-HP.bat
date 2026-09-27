@echo off
setlocal
cd /d "%~dp0"
title Langkah 3 - Tes di HP (JANGAN tutup jendela ini)
set "PATH=%ProgramFiles%\nodejs;%PATH%"

if exist "node_modules" goto jalan
echo Kamu belum menjalankan 1-INSTALL.bat. Menjalankannya dulu ...
call "%~dp01-INSTALL.bat"
if not exist "node_modules" exit /b 1

:jalan
echo ==========================================================
echo    LANGKAH 3 : TES DI HP
echo    (npm run build  lalu  npm run preview -- --host)
echo ==========================================================
echo.
call npm run build
if errorlevel 1 goto gagal
echo.
echo ----------------------------------------------------------
echo  Cari baris yang tulisannya  "Network:  http://192.168...."
echo  Ketik alamat itu PERSIS di browser Chrome HP kamu.
echo  Syarat: HP dan laptop pakai WiFi yang SAMA.
echo.
echo  Kalau muncul jendela Windows Firewall, klik "Allow access".
echo  Untuk berhenti: tutup jendela ini.
echo ----------------------------------------------------------
echo.
call npm run preview -- --host --open
pause
exit /b 0

:gagal
echo.
echo Build gagal. Jalankan 1-INSTALL.bat lagi, lalu coba file ini lagi.
pause
exit /b 1
