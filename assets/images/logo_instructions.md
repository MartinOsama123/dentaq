# Logo Instructions

## Required File: logo.png

Place your `logo.png` file in this directory (`assets/images/`).

### Requirements:
- **File name:** `logo.png`
- **Recommended size:** 512x512 pixels (square format)
- **Format:** PNG with transparent background
- **Usage:** This logo will be displayed in the app bar and splash screen

### Notes:
- The app bar will display the logo at 32x32 pixels
- The splash screen will scale the logo appropriately
- If the logo.png file is not found, a fallback icon will be displayed
- For best results, use a high-resolution logo that scales well

### Once you add the logo.png file:
1. Place it in this directory as `logo.png`
2. Run `flutter pub get`
3. Run `flutter pub run flutter_native_splash:create` to generate splash screens
4. The app bar will automatically display your logo 