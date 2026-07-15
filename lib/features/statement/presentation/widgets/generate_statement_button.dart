import 'package:flutter/material.dart';

import '../screens/statement_preview_screen.dart';

class GenerateStatementButton
    extends StatelessWidget {
  const GenerateStatementButton({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return FilledButton.icon(
      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const StatementPreviewScreen(),
          ),
        );

      },

      icon: const Icon(
        Icons.visibility_rounded,
      ),

      label: const Text(
        'Preview Statement',
      ),

      style: FilledButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          56,
        ),
      ),
    );
  }
}