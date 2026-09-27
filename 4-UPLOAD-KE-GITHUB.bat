@echo off
setlocal
cd /d "%~dp0"
title Langkah 4 - Upload ke GitHub
set "PATH=%ProgramFiles%\Git\cmd;%ProgramFiles%\nodejs;%PATH%"

echo ==========================================================
echo    LANGKAH 4 : UPLOAD (PUSH) KE GITHUB KAMU
echo ==========================================================
echo.

where git >nul 2>nul
if errorlevel 1 goto no_git

if exist ".git" goto repo_ada
git init -b main >nul 2>nul
if errorlevel 1 git init >nul
:repo_ada

git config user.name >nul 2>nul
if not errorlevel 1 goto nama_ok
set /p GNAME=Ketik NAMA kamu lalu tekan Enter:
git config --global user.name "%GNAME%"
:nama_ok

git config user.email >nul 2>nul
if not errorlevel 1 goto email_ok
set /p GMAIL=Ketik EMAIL akun GitHub kamu lalu tekan Enter:
git config --global user.email "%GMAIL%"
:email_ok

echo Menyiapkan file ...
git add -A
git commit -q -m "feat: modul 4 PWA gunshop" >nul 2>nul
git branch -M main

git remote get-url origin >nul 2>nul
if not errorlevel 1 goto push

:minta_link
echo.
echo Tempel (paste) link repository GitHub kamu di bawah ini.
echo Cara paste: tekan Ctrl+V  atau  klik kanan di jendela ini.
echo Contoh: https://github.com/namakamu/gunshop-modul4-kelxx.git
echo.
set "REPO="
set /p REPO=Link repo:
if "%REPO%"=="" goto minta_link
git remote add origin %REPO%

:push
echo.
echo Mengirim ke GitHub ...
echo Kalau muncul jendela "Connect to GitHub", klik "Sign in with your browser",
echo lalu di browser klik tombol hijau "Authorize".
echo.
git push -u origin main
if not errorlevel 1 goto sukses

echo.
echo Push gagal. Penyebab paling sering: repo GitHub kamu tidak kosong
echo (misalnya waktu membuat repo kamu menyalakan "Add README").
choice /c YN /m "Timpa isi repo GitHub dengan proyek ini? Tekan Y untuk ya, N untuk tidak"
if errorlevel 2 goto gagal
git push -u origin main --force
if errorlevel 1 goto gagal

:sukses
echo.
echo ==========================================================
echo    BERHASIL. Kode sudah ada di GitHub kamu.
echo    Browser akan membuka halaman repo kamu.
echo    Lanjut ke langkah Vercel di PANDUAN.html
echo ==========================================================
for /f "delims=" %%u in ('git remote get-url origin') do start "" "%%u"
echo.
pause
exit /b 0

:gagal
git remote remove origin >nul 2>nul
echo.
echo Upload belum berhasil. Link repo sudah direset.
echo Cek lagi link repo-nya, lalu double-click file ini sekali lagi.
pause
exit /b 1

:no_git
echo Git belum terpasang di laptop ini.
echo Browser akan membuka halaman download Git:
echo   1. Klik "Click here to download"
echo   2. Buka file yang terdownload, klik Next terus sampai Finish
echo   3. Double-click lagi file 4-UPLOAD-KE-GITHUB.bat ini
start "" https://git-scm.com/download/win
pause
exit /b 1
