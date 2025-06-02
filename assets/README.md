# Assets Directory

This directory contains asset files for the DentaQ Flutter application.

## Structure

- `svg/` - Contains SVG vector graphics files
- `images/` - Contains raster images (PNG, JPG) including logos
- `icons/` - Contains app icon source files

## Usage

### Images (PNG/JPG)

Place your image files in the `assets/images/` directory. To use image files in your Flutter app:

```dart
// For regular images:
Image.asset(
  'assets/images/your_image.png',
  width: 100,
  height: 100,
)

// For the app logo (already implemented in CustomAppBar):
Image.asset('assets/images/logo.png')
```

**Required files:**
- `logo.png` - App logo displayed in the app bar and splash screen (512x512 recommended)

### SVG Files

Place your SVG files in the `assets/svg/` directory. To use SVG files in your Flutter app, you'll need to add the `flutter_svg` package to your dependencies:

```yaml
dependencies:
  flutter_svg: ^2.1.0
```

Then import and use SVG files like this:

```dart
import 'package:flutter_svg/flutter_svg.dart';

// In your widget:
SvgPicture.asset(
  'assets/svg/your_icon.svg',
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
)
```

### App Icons

Place your app icon source file in the `assets/icons/` directory:

**Required files:**
- `app_icon.png` - App icon source file (1024x1024 recommended)

**To generate app icons:**
```bash
flutter pub run flutter_launcher_icons:main
```

## Splash Screen

The splash screen is configured to use `assets/images/logo.png`. To generate splash screens:

```bash
flutter pub run flutter_native_splash:create
```

## Adding New Assets

1. Place your files in the appropriate subdirectory:
   - Images → `assets/images/`
   - SVG files → `assets/svg/`
   - App icons → `assets/icons/`
2. The assets are already configured in `pubspec.yaml` to include all these directories
3. Run `flutter pub get` if you've added new asset files
4. For app icons and splash screens, run the respective generation commands shown above 