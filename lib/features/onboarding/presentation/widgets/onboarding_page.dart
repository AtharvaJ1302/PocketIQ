import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_duration.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../domain/models/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingItem item;
  final int index;
  final ValueNotifier<double> pageOffset;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.index,
    required this.pageOffset,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
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

  Widget _buildTitle(double fontSize) {
    final words = widget.item.title.split(" ");

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: "${words.sublist(0, words.length - 1).join(" ")}\n",
          ),
          WidgetSpan(
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xff6D5BFF),
                    Color(0xff8C7DFF),
                    Colors.white,
                  ],
                ).createShader(bounds);
              },
              child: Text(
                words.last,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _particle(
      double left,
      double top,
      double radius,
      ) {
    return Positioned(
      left: left,
      top: top,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Opacity(
            opacity: .3 + (_controller.value * .7),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: const Color(0xff8C7DFF),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 700;

        final imageHeight =
        (constraints.maxHeight * .30).clamp(150.0, 260.0);

        final glowSize = imageHeight * 1.35;

        final titleSize = compact ? 30.0 : 38.0;

        final descriptionSize = compact ? 16.0 : 18.0;

        final floatDistance = compact ? 5.0 : 8.0;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: AppDuration.slow,
          curve: Curves.easeOutCubic,
          builder: (_, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Stack(
            children: [

              _particle(40, 90, 2),
              _particle(constraints.maxWidth - 70, 170, 3),
              _particle(70, 300, 2),

              Padding(
                padding: AppSpacing.screenPadding,
                child: SingleChildScrollView(
                  physics: compact
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                      constraints.maxHeight -
                          AppSpacing.screenPadding.vertical,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: compact ? 8 : 16),

                        ValueListenableBuilder<double>(
                          valueListenable: widget.pageOffset,
                          builder: (_, page, child) {
                            final delta = widget.index - page;

                            return Transform.translate(
                              offset: Offset(delta * 15, 0),
                              child: child,
                            );
                          },
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (_, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  -floatDistance *
                                      _controller.value,
                                ),
                                child: child,
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (_, __) {
                                    return Transform.scale(
                                      scale:
                                      1 +
                                          (_controller.value *
                                              .08),
                                      child: Container(
                                        width: glowSize,
                                        height: glowSize,
                                        decoration:
                                        BoxDecoration(
                                          shape:
                                          BoxShape.circle,
                                          gradient:
                                          RadialGradient(
                                            colors: [
                                              const Color(
                                                0xff6D5BFF,
                                              ).withOpacity(.28),
                                              Colors
                                                  .transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Hero(
                                  tag: widget.item.title,
                                  child: Transform.translate(
                                    offset: Offset(
                                      widget.index == 0 ? 10 : 0,
                                      0,
                                    ),
                                  child: RepaintBoundary(
                                    child: Image.asset(
                                      widget.item.image,
                                      height: imageHeight,
                                      fit: BoxFit.contain,
                                      filterQuality:
                                      FilterQuality.high,
                                      gaplessPlayback: true,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: compact ? 12 : 18),

                        Transform.translate(
                          offset: Offset(
                            widget.index == 0 ? 10 : 0,
                            0,
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.item.category,
                                style: const TextStyle(
                                  color: Color(0xffA798FF),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.5,
                                ),
                              ),

                              const SizedBox(height: 16),

                              _buildTitle(titleSize),

                              const SizedBox(height: 18),

                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 340,
                                ),
                                child: Text(
                                  widget.item.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: descriptionSize,
                                    height: 1.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}