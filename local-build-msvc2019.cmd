REM run as Administrator
@echo off
cd /d %~dp0
set DOWNLOAD_DIR=%USERPROFILE%\Downloads
set DOWNLOAD_DIR_LINUX=%DOWNLOAD_DIR:\=/%
@REM %DOWNLOAD_DIR%\mingw64-win32; ^
@REM %DOWNLOAD_DIR%\mingw64-win32\bin; ^

SET PATH=%DOWNLOAD_DIR%\PortableGit\bin;%DOWNLOAD_DIR%\cmake-3.22.2-windows-x86_64\bin;

cmake -G "Visual Studio 16 2019" -A x64 ^
-DOR_TOOLS_ROOT="%~dp0../or-tools_VisualStudio2019-64bit_v9.2.9972" ^
-DBUILD_SHARED_LIBS=OFF ^
-DCMAKE_INSTALL_PREFIX="%~dp0build/or-tools" -B./build

cd build
cmake --build . --target ALL_BUILD --config Release -- /nologo /verbosity:minimal /maxcpucount

pause

