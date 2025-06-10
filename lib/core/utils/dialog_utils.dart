import 'package:flutter/material.dart';
import '../../shared/widgets/custom_button.dart';

class DialogUtils {
  /// Show a confirmation dialog with title, message, and customizable buttons
  /// Returns true if confirmed, false if cancelled, null if dismissed
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String? cancelText = 'Cancel',
    bool isDestructive = false,
    bool barrierDismissible = true,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          title: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF044D5E),
              ),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF044D5E),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            // Cancel button (if provided)
            if (cancelText != null)
              Expanded(
                child: CustomButton(
                  text: cancelText,
                  onPressed: () => Navigator.of(context).pop(false),
                  destructive: true,
                  height: 55,
                  width: 150,
                  borderRadius: 40,
                ),
              ),

            // Add spacing between buttons if both exist
            if (cancelText != null) const SizedBox(width: 12),

            // Confirmation button
            Expanded(
              child: CustomButton(
                text: confirmText,
                onPressed: () => Navigator.of(context).pop(true),
                destructive: isDestructive,
                height: 55,
                width: 159,
                borderRadius: 40,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show a simple alert dialog with just an OK button
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    bool barrierDismissible = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF044D5E),
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF044D5E),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            CustomButton(
              text: buttonText,
              onPressed: () => Navigator.of(context).pop(),
              height: 45,
              borderRadius: 8,
              width: double.infinity,
            ),
          ],
        );
      },
    );
  }

  /// Show a loading dialog
  static void showLoadingDialog({
    required BuildContext context,
    String message = 'Loading...',
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF044D5E),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }

  /// Hide the currently showing dialog
  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // SNACKBAR METHODS

  /// Show a success snackbar
  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
    IconData? trailingIcon,
    VoidCallback? onTrailingIconPressed,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showCustomSnackbar(
      context: context,
      message: message,
      leadingIcon: Icons.check_circle,
      trailingIcon: trailingIcon,
      onTrailingIconPressed: onTrailingIconPressed,
      duration: duration,
    );
  }

  /// Show an error/failure snackbar
  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
    IconData? trailingIcon,
    VoidCallback? onTrailingIconPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showCustomSnackbar(
      context: context,
      message: message,
      leadingIcon: Icons.error,
      trailingIcon: trailingIcon,
      onTrailingIconPressed: onTrailingIconPressed,
      duration: duration,
    );
  }

  /// Show a custom snackbar with specified icon and styling
  static void showCustomSnackbar({
    required BuildContext context,
    required String message,
    required IconData leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onTrailingIconPressed,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showCustomSnackbar(
      context: context,
      message: message,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      onTrailingIconPressed: onTrailingIconPressed,
      duration: duration,
    );
  }

  /// Internal method to show custom snackbar
  static void _showCustomSnackbar({
    required BuildContext context,
    required String message,
    required IconData leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onTrailingIconPressed,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Leading icon
              Icon(
                leadingIcon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),

              // Message text
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Trailing icon (if provided)
              if (trailingIcon != null)
                GestureDetector(
                  onTap: onTrailingIconPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      trailingIcon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF044D5E),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
