@echo off
echo DentaQ Asset Setup Script
echo =========================

echo.
echo Checking for required asset files...

:: Check for logo.png
if exist "assets\images\logo.jpg" (
    echo ✓ Logo file found: assets\images\logo.jpg
) else (
    echo ✗ Logo file missing: assets\images\logo.jpg
    echo   Please add your logo.jpg file to assets\images\ directory
    echo   Recommended size: 512x512 pixels
    echo.
)

:: Check for app_icon.png
if exist "assets\icons\app_icon.jpg" (
    echo ✓ App icon file found: assets\icons\app_icon.jpg
) else (
    echo ✗ App icon file missing: assets\icons\app_icon.jpg
    echo   Please add your app_icon.jpg file to assets\icons\ directory
    echo   Recommended size: 1024x1024 pixels
    echo.
)

echo.
echo Running flutter pub get...
flutter pub get

echo.
if exist "assets\images\logo.png" (
    echo Generating splash screens...
    flutter pub run flutter_native_splash:create
    echo ✓ Splash screens generated
) else (
    echo Skipping splash screen generation (logo.png not found)
)

echo.
if exist "assets\icons\app_icon.jpg" (
    echo Generating app icons...
    flutter pub run flutter_launcher_icons:main
    echo ✓ App icons generated
) else (
    echo Skipping app icon generation (app_icon.jpg not found)
)

echo.
echo Setup complete!
echo.
echo Next steps:
echo 1. Add your logo.jpg to assets\images\ (if not already done)
echo 2. Add your app_icon.jpg to assets\icons\ (if not already done)
echo 3. Run this script again to generate assets
echo 4. Run 'flutter run' to see your app with the new assets
echo.
pause 