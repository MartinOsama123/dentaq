# Authentication System Usage Guide

This guide explains how to use the authentication system implemented in the DentaQ app.

## Overview

The authentication system provides:
- Login and Register functionality with API integration
- Secure token and user data storage using SharedPreferences
- Easy access to user data across the app
- Automatic session management
- **User Dashboard accessible via Account tab**

## Navigation Flow

### New User Experience
1. App opens → Products screen (main shopping experience)
2. User clicks **Account tab** → Shows Login/Register screen if not logged in
3. After login/register → **Automatically switches to Account tab and shows Dashboard with welcome animation**

### Authentication Process
1. User clicks Account tab → Auth screen (if not logged in)
2. User completes login/register → **Automatic tab switch with smooth transition**
3. Dashboard appears with welcome animation and provides access to:
   - Browse Products (return to shopping experience)
   - User menu items (wishlist, account info, etc.)

### Dashboard Features (Account Tab)
- **Welcome animation** when arriving from authentication
- **Smooth tab transition** - automatically highlights Account tab
- **Success notifications** with redirect messages
- **Welcome section** with user avatar and info
- **Browse Products button** to return to shopping functionality
- **Menu items** with alternating background colors:
  1. My Wishlist (white background)
  2. Account Information (dark teal background)
  3. Address Book (white background) 
  4. Notifications (dark teal background)
  5. Logout (white background, red text)
- **Confirmation dialog** for logout
- **Appropriate icons** for each menu item

## API Endpoints

### Login
- **Endpoint**: `POST /auth/login`
- **Body**:
```json
{
  "email": "mymail@mail.com",
  "password": "testpassword"
}
```

### Register
- **Endpoint**: `POST /auth/register`
- **Body**:
```json
{
  "username": "john_doe2",
  "password": "StrongP@ssw0rd",
  "fullName": "John Doe",
  "email": "john.doe2@example.com",
  "mobile": "+1234567890"
}
```

### Response Format (Both endpoints)
```json
{
    "message": "Login successful",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
        "id": "6847e4c4a56037d3c736c644",
        "email": "john.doe2@example.com",
        "fullName": "John Doe",
        "username": "john_doe2020"
    }
}
```

## How to Access User Data

### Method 1: Using AuthUtils (Recommended)

The `AuthUtils` class provides static methods for easy access to user data:

```dart
import 'package:dentaq/core/utils/auth_utils.dart';

// Get user ID
String? userId = await AuthUtils.getUserId();

// Get authentication token
String? token = await AuthUtils.getToken();

// Get full user object
User? user = await AuthUtils.getUser();

// Check if user is logged in
bool isLoggedIn = await AuthUtils.isLoggedIn();

// Get specific user properties
String? email = await AuthUtils.getUserEmail();
String? fullName = await AuthUtils.getUserFullName();
String? username = await AuthUtils.getUsername();

// Get authorization headers for API requests
Map<String, String>? headers = await AuthUtils.getAuthHeaders();

// Logout user
await AuthUtils.logout();
```

### Method 2: Using Riverpod Providers

You can also use Riverpod providers for reactive state management:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dentaq/features/auth/presentation/providers/auth_providers.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch current user
    final currentUserAsync = ref.watch(currentUserProvider);
    
    // Watch login status
    final isLoggedInAsync = ref.watch(isLoggedInProvider);
    
    // Watch user ID
    final userIdAsync = ref.watch(currentUserIdProvider);
    
    // Watch token
    final tokenAsync = ref.watch(currentTokenProvider);
    
    return currentUserAsync.when(
      data: (user) {
        if (user != null) {
          return Text('Hello, ${user.fullName}!');
        }
        return Text('Not logged in');
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## Authentication Flow

### Login Process
1. User clicks Account tab (shows auth screen if not logged in)
2. User enters email and password
3. App calls `/auth/login` endpoint
4. On success, token and user data are saved locally
5. **Account tab immediately shows dashboard**
6. User data is accessible throughout the app

### Register Process
1. User clicks Account tab (shows auth screen if not logged in)
2. User enters username, fullName, email, mobile, and password
3. App calls `/auth/register` endpoint
4. On success, token and user data are saved locally
5. **Account tab immediately shows dashboard**
6. User data is accessible throughout the app

### Logout Process
1. User clicks logout from Account tab dashboard
2. **Confirmation dialog appears**
3. On confirmation, local storage is cleared (token and user data)
4. **Account tab immediately shows auth screen again**

## Storage

User data and tokens are stored locally using SharedPreferences with the following keys:
- `auth_token`: Authentication token
- `user_data`: User data as JSON string

## Error Handling

The authentication system includes comprehensive error handling:
- Network connectivity checks
- API error responses
- Timeout handling
- Data validation
- User-friendly error messages

## Security Features

- Tokens are stored securely using SharedPreferences
- API requests include proper headers
- Network security configuration for HTTPS
- Input validation on forms
- Password visibility toggles

## Example Usage in Screens

See `lib/features/account/presentation/screens/account_screen.dart` for a complete example of how to:
- Check if user is logged in
- Display user information
- Handle logout functionality
- Use both AuthUtils and Riverpod providers

## Making Authenticated API Requests

When making API requests that require authentication:

```dart
// Get auth headers
final headers = await AuthUtils.getAuthHeaders();

if (headers != null) {
  final response = await http.get(
    Uri.parse('$baseUrl/protected-endpoint'),
    headers: headers,
  );
  // Handle response
} else {
  // User not logged in, redirect to auth
}
```

## Navigation Routes

The app now includes these main routes:
- `/` - Root redirects to `/products`
- `/auth` - Login/Register screen (standalone)
- `/products` - Shopping/browsing experience (with bottom navigation)
- `/cart` - Shopping cart (with bottom navigation)
- `/wishlist` - User wishlist (with bottom navigation)
- `/account` - **User Dashboard or Auth screen** (with bottom navigation)

## Account Tab Behavior

The Account tab in the bottom navigation intelligently shows:
- **Auth screen** (login/register) if user is not logged in
- **User Dashboard** if user is logged in

### Dashboard Customization

When logged in, the Account tab shows the dashboard with:
- **User welcome section** with avatar and basic info
- **Browse Products** button to return to shopping
- **Menu list** with proper styling:
  - Icons: wishlist, account, address, notifications, logout
  - Alternating backgrounds (white/dark teal)
  - Red styling for logout item
  - Proper dividers with red color before logout 