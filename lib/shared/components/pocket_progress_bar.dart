import 'package:flutter/material.dart';

class PocketProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;

  const PocketProgressBar({
    super.key,
    required this.progress,
    this.width = 280,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white10
            : Colors.black12,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: width * progress,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xff6366F1),
                Color(0xff06B6D4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}