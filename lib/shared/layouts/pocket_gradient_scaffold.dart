import 'package:flutter/material.dart';

import '../../../app/theme/colors/app_gradients.dart';

class PocketGradientScaffold extends StatelessWidget {
  final Widget child;

  final bool resizeToAvoidBottomInset;

  const PocketGradientScaffold({
    super.key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset:
      resizeToAvoidBottomInset,
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: dark
              ? AppGradients.darkBackground
              : AppGradients.lightBackground,
        ),
        child: child,
      ),
    );
  }
}