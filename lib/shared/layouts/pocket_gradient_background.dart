import 'package:flutter/material.dart';

import '../../../app/theme/colors/app_gradients.dart';

class PocketGradientBackground extends StatelessWidget {
  final Widget child;

  const PocketGradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: dark
            ? AppGradients.darkBackground
            : AppGradients.lightBackground,
      ),
      child: child,
    );
  }
}