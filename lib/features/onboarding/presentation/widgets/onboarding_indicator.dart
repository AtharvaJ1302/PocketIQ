import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final selected = currentPage == index;

          return AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            scale: selected ? 1.0 : .9,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 5),

              width: selected ? 36 : 9,
              height: selected ? 10 : 9,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),

                gradient: selected
                    ? const LinearGradient(
                  colors: [
                    Color(0xff6D5BFF),
                    Color(0xff8C7DFF),
                  ],
                )
                    : null,

                color: selected
                    ? null
                    : (isDark
                    ? Colors.white24
                    : const Color(0xFFD6CCFF)),

                boxShadow: selected
                    ? [
                  BoxShadow(
                    color: const Color(0xff6D5BFF).withOpacity(
                      isDark ? .45 : .25,
                    ),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ]
                    : [],
              ),
            ),
          );
        }),
      ),
    );
  }
}