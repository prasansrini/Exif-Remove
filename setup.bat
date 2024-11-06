@echo off

REM Remove the output/exif.exe file
if exist output\exif.exe (
    del output\exif.exe
)

REM Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please install Python from https://www.python.org/downloads/
    exit /b
)

REM Check if pip is installed
pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Pip is not installed. Installing pip...
    python -m ensurepip --upgrade
)

REM Install the required packages
pip install Pillow pyinstaller

REM Run pyinstaller on exif.py
pyinstaller exif.py --log-level ERROR || exit /b

REM Copy the output file to the desired location
IF EXIST "dist\exif\exif.exe" (
    copy "dist\exif\exif.exe" "output\exif.exe" || exit /b
)

REM Remove the dist and build directories
rmdir /s /q dist
rmdir /s /q build

echo Process complete.