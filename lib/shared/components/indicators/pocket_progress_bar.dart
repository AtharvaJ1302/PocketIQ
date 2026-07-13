import 'package:flutter/material.dart';

class PocketProgressBar extends StatelessWidget {
  final double progress;
  final double? width;
  final double height;
  final Gradient? gradient;
  final Color? backgroundColor;

  const PocketProgressBar({
    super.key,
    required this.progress,
    this.width,
    this.height = 8,
    this.gradient,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final trackColor = backgroundColor ??
        (theme.brightness == Brightness.dark
            ? Colors.white10
            : Colors.black12);

    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = width ?? constraints.maxWidth;

        return Container(
          width: barWidth,
          height: height,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius:
            BorderRadius.circular(100),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 350,
              ),
              curve: Curves.easeOut,
              width: barWidth * progress.clamp(0, 1),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(100),
                gradient: gradient ??
                    const LinearGradient(
                      colors: [
                        Color(0xff6366F1),
                        Color(0xff06B6D4),
                      ],
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}