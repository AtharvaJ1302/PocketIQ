import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../shared/components/indicators/pocket_progress_bar.dart';

class OverallBudgetCard extends StatelessWidget {
  final double totalBudget;
  final double spent;
  final double remaining;
  final double progress;

  const OverallBudgetCard({
    super.key,
    required this.totalBudget,
    required this.spent,
    required this.remaining,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderRadiusXl,
          gradient: theme.brightness == Brightness.dark
              ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C2B57),
              Color(0xFF1A1C3D),
              Color(0xFF101427),
            ],
            stops: [0.0, .55, 1],
          )
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainer,
            ],
          ),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF6F63FF).withValues(alpha: .22)
                : theme.colorScheme.outlineVariant.withValues(alpha: .35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .28),
              blurRadius: 30,
              spreadRadius: -6,
              offset: const Offset(0, 14),
            ),
          ],
        ),

        child: ClipRRect(
            borderRadius: AppRadius.borderRadiusXl,
            child: Stack(
              children: [

              /// Purple glow (top-left)
              Positioned(
              top: -120,
              left: -90,
              child: IgnorePointer(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0x557C5CFF),
                        Colors.transparent,
                      ],
                      stops: [.0, 1],
                    ),
                  ),
                ),
              ),
            ),

            /// Blue glow (bottom-right)
            Positioned(
              bottom: -150,
              right: -120,
              child: IgnorePointer(
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0x22139BFF),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// Soft top highlight
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: .05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// Existing content
            Padding(
      padding: const EdgeInsets.all(24),

      child: Column(
        children: [

          Center(
            child: SizedBox(
              width: 110,
              height: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [

                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(
                      value: progress.clamp(0, 1),
                      strokeWidth: 10,
                      backgroundColor: theme.colorScheme.outlineVariant
                          .withValues(alpha: .25),
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF7C5CFF),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        'of budget\nused',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Monthly Budget',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Track your spending this month',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 28),

          IntrinsicHeight(
            child: Row(
              children: [

                Expanded(
                  child: _Metric(
                    title: 'Budget',
                    value: CurrencyFormatter.format(totalBudget),
                    color: const Color(0xff7C5CFF),
                  ),
                ),

                VerticalDivider(
                  thickness: 1,
                  color: theme.colorScheme.outlineVariant
                      .withValues(alpha: .25),
                ),

                Expanded(
                  child: _Metric(
                    title: 'Spent',
                    value: CurrencyFormatter.format(spent),
                    color: const Color(0xffFF8A34),
                  ),
                ),

                VerticalDivider(
                  thickness: 1,
                  color: theme.colorScheme.outlineVariant
                      .withValues(alpha: .25),
                ),

                Expanded(
                  child: _Metric(
                    title: remaining < 0 ? 'Left' : 'Left',
                    value: CurrencyFormatter.format(
                      remaining.abs(),
                    ),
                    color: remaining < 0
                        ? Colors.red
                        : const Color(0xff38D67A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
            ),
              ],
            ),
        ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _Metric({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 6),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}