import 'package:dentaq/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final bool destructive;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.destructive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Apply destructive styling when destructive is true
    Color finalBackgroundColor;
    Color finalTextColor;
    BorderSide? borderSide;

    if (destructive) {
      finalBackgroundColor = backgroundColor ?? Colors.white;
      finalTextColor = textColor ?? Colors.red;
      borderSide = const BorderSide(color: Colors.red);
    } else {
      finalBackgroundColor = backgroundColor ?? Theme.of(context).primaryColor;
      finalTextColor = textColor ?? Theme.of(context).colorScheme.onPrimary;
      borderSide = null;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: finalBackgroundColor,
          foregroundColor: finalTextColor,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: destructive ? Colors.red : AppTheme.textColor)),
      ),
    );
  }
}
