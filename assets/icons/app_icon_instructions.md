# App Icon Instructions

## Required File: app_icon.png

Place your `app_icon.png` file in this directory (`assets/icons/`).

### Requirements:
- **File name:** `app_icon.png`
- **Recommended size:** 1024x1024 pixels (square format)
- **Format:** PNG with transparent or solid background
- **Usage:** This will be your app's home screen icon

### Platform-specific requirements:
- **Android:** The icon will be generated for all required densities
- **iOS:** The icon will be generated for all required sizes
- **Web:** Icon will be used for PWA and favicon
- **Windows/macOS:** Desktop app icons

### Notes:
- Use a high-resolution (1024x1024) source image for best quality
- The icon should work well at small sizes (consider simplicity)
- Avoid including text in the icon as it may become unreadable at small sizes

### Once you add the app_icon.png file:
1. Place it in this directory as `app_icon.png`
2. Run `flutter pub get`
3. Run `flutter pub run flutter_launcher_icons:main` to generate app icons
4. Your app will display the custom icon on all platforms

### Color configuration:
You may want to update the background and theme colors in `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  # ... other config
  web:
    background_color: "#your_color_here"
    theme_color: "#your_color_here"
``` 