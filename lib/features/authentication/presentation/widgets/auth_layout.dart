import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import 'auth_footer.dart';
import 'auth_header.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  final String footerText;
  final String footerActionText;
  final VoidCallback onFooterPressed;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.footerText,
    required this.footerActionText,
    required this.onFooterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            padding: AppSpacing.screenPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.huge),

                  AuthHeader(
                    title: title,
                    subtitle: subtitle,
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  child,

                  const SizedBox(height: AppSpacing.xxxl),

                  AuthFooter(
                    text: footerText,
                    actionText: footerActionText,
                    onPressed: onFooterPressed,
                  ),

                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}