@echo off
setlocal
cd /d "%~dp0"
title Langkah 2 - Web sedang jalan (JANGAN tutup jendela ini)
set "PATH=%ProgramFiles%\nodejs;%PATH%"

if exist "node_modules" goto jalan
echo Kamu belum menjalankan 1-INSTALL.bat. Menjalankannya dulu ...
call "%~dp01-INSTALL.bat"
if not exist "node_modules" exit /b 1

:jalan
echo ==========================================================
echo    LANGKAH 2 : MENJALANKAN WEB DI LAPTOP  (npm run dev)
echo ==========================================================
echo.
echo  - Browser akan terbuka sendiri ke  http://localhost:5173
echo  - Kalau tidak terbuka, ketik alamat itu di Chrome.
echo  - Selama web dipakai, JANGAN tutup jendela hitam ini.
echo  - Untuk berhenti: tutup jendela ini (klik X).
echo.
call npm run dev -- --open
pause
