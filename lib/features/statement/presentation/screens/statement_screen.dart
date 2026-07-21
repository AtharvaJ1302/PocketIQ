import 'package:flutter/material.dart';

import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../widgets/generate_statement_button.dart';
import '../widgets/statement_filter_card.dart';
import '../widgets/statement_include_card.dart';
import '../widgets/statement_type_selector.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Generate Statement',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: SafeArea(
          child: ListView(
            padding: AppSpacing.screenPadding,
            children: [

              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.section,
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Create and export your financial statement.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: .08),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.description_rounded,
                        color:
                        Theme.of(context).colorScheme.primary,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),

              const StatementTypeSelector(),

              SizedBox(
                height: AppSpacing.section,
              ),

              const StatementFilterCard(),

              SizedBox(
                height: AppSpacing.section,
              ),

              const StatementIncludeCard(),

              SizedBox(
                height: AppSpacing.section,
              ),

              Container(
                padding: const EdgeInsets.all(
                  AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  gradient: theme.brightness == Brightness.dark
                      ? const LinearGradient(
                    colors: [
                      Color(0xFF26294A),
                      Color(0xFF1F2242),
                    ],
                  )
                      : const LinearGradient(
                    colors: [
                      Color(0xFFF7F5FF),
                      Color(0xFFEEF2FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: .12),
                  ),
                ),
                child: Row(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? theme.colorScheme.primary.withValues(alpha: .08)
                            : theme.colorScheme.primaryContainer.withValues(alpha: .65),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha: .12),
                        ),
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 16),


                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Your data is 100% private',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Statements are generated locally and never uploaded.',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              const GenerateStatementButton(),

              const SizedBox(
                height: AppSpacing.xl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}