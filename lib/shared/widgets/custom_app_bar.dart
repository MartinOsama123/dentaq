import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? titleIcon;
  final List<Widget>? actions;
  final bool showLogo;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? height;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleIcon,
    this.actions,
    this.showLogo = true,
    this.showBackButton = false,
    this.backgroundColor,
    this.titleColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Auto-detect if we can navigate back
    final canPop = Navigator.of(context).canPop();
    final shouldShowNavigation = canPop || showBackButton;
    final shouldShowLogo = showLogo && !shouldShowNavigation;

    Widget? appBarContent;

    if (shouldShowNavigation && title != null) {
      // Navigation mode: show icon + title
      appBarContent = Row(
        children: [
          if (titleIcon != null) ...[
            Icon(
              titleIcon,
              color: titleColor ?? AppTheme.textColor,
              size: 24,
            ),
            const SizedBox(width: 12),
          ],
          Text(
            title!,
            style: TextStyle(
              color: titleColor ?? AppTheme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else if (shouldShowLogo) {
      // Logo mode: show logo + app name
      appBarContent = Row(
        children: [
          // Logo
          SvgPicture.asset(
            'assets/svg/logo.svg',
            height: 32,
            width: 32,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.white,
                  size: 20,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          // App name could be added here if needed
        ],
      );
    } else if (title != null) {
      // Simple title mode
      appBarContent = Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: titleColor ?? Theme.of(context).colorScheme.onSurface,
            ),
      );
    }

    // Handle horizontal and vertical padding
    Widget? finalContent = appBarContent;
    if ((horizontalPadding != null || verticalPadding != null) &&
        appBarContent != null) {
      finalContent = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 0,
        ),
        child: appBarContent,
      );
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? kToolbarHeight),
      child: Container(
        padding: horizontalPadding != null || verticalPadding != null
            ? EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 0,
                vertical: verticalPadding ?? 0,
              )
            : null,
        child: AppBar(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 1,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          leading: shouldShowNavigation
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: titleColor ?? Theme.of(context).colorScheme.onSurface,
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          title: (horizontalPadding == null && verticalPadding == null)
              ? finalContent
              : appBarContent,
          actions: actions,
          automaticallyImplyLeading: shouldShowNavigation,
          centerTitle: false,
          toolbarHeight: height,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
