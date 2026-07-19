import 'package:flutter/material.dart';

class OnboardingBottomBar extends StatefulWidget {
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingBottomBar({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  State<OnboardingBottomBar> createState() =>
      _OnboardingBottomBarState();
}

class _OnboardingBottomBarState
    extends State<OnboardingBottomBar> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final buttonWidth = (width * .48).clamp(165.0, 240.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        28,
        0,
        28,
        28,
      ),
      child: Row(
        children: [
          AnimatedOpacity(
            opacity: widget.isLastPage ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: IgnorePointer(
              ignoring: widget.isLastPage,
              child: TextButton(
                onPressed: widget.onSkip,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff8C7DFF),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTapDown: (_) {
              setState(() => _pressed = true);
            },
            onTapUp: (_) {
              setState(() => _pressed = false);
            },
            onTapCancel: () {
              setState(() => _pressed = false);
            },
            onTap: widget.onNext,
            child: AnimatedScale(
              scale: _pressed ? .96 : 1,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: SizedBox(
                width: buttonWidth,
                height: 62,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff6D5BFF),
                          Color(0xff7D6DFF),
                          Color(0xff8C7DFF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff6D5BFF)
                              .withOpacity(0),
                          blurRadius: 24,
                          spreadRadius: 1,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      splashColor:
                      Colors.white.withOpacity(.12),
                      highlightColor:
                      Colors.white.withOpacity(.05),
                      onTap: widget.onNext,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          transitionBuilder:
                              (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin:
                                  const Offset(.15, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            widget.isLastPage
                                ? "Get Started →"
                                : "Next →",
                            key: ValueKey(
                              widget.isLastPage,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.w700,
                              letterSpacing: .2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}