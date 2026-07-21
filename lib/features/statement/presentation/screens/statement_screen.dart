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

    return Scaffold(
      appBar: AppBar(
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
            children: const [
              StatementTypeSelector(),

              SizedBox(
                height: AppSpacing.section,
              ),

              StatementFilterCard(),

              SizedBox(
                height: AppSpacing.section,
              ),

              StatementIncludeCard(),

              SizedBox(
                height: AppSpacing.xl,
              ),

              GenerateStatementButton(),
            ],
          ),
        ),
      ),
    );
  }
}