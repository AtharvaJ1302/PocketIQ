import 'package:flutter/material.dart';

import '../../../../app/theme/colors/app_colors.dart';
import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_duration.dart';

class SetupHeader extends StatefulWidget {
  final String image;

  final String eyebrow;

  final String title;

  final String subtitle;

  const SetupHeader({
    super.key,
    required this.image,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  @override
  State<SetupHeader> createState() =>
      _SetupHeaderState();
}

class _SetupHeaderState
    extends State<SetupHeader>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _gradientTitle() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return AppGradients.primary.createShader(bounds);
      },
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppDuration.slow,
      curve: Curves.easeOutCubic,
      builder: (_, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              30 * (1 - value),
            ),
            child: child,
          ),
        );
      },
      child: Column(
        children: [

          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  -8 * _controller.value,
                ),
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [

                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.glow.withOpacity(
                          dark ? .35 : .18,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),


                  Image.asset(
                    widget.image,
                    height: 135,
                    fit: BoxFit.contain,
                  ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            widget.eyebrow.toUpperCase(),
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
            ),
          ),

          const SizedBox(height: 10),

          _gradientTitle(),

          const SizedBox(height: 18),

          ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 320,
            ),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                dark
                    ? Colors.white70
                    : Colors.black54,
                fontSize: 17,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}