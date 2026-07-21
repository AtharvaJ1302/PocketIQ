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
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // or AppRadius.borderRadiusMd
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff6D5BFF),
            Color(0xff7D6DFF),
            Color(0xff8C7DFF),
          ],
        ),
      ),
      child: FilledButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const StatementPreviewScreen(),
            ),
          );
        },
        icon: const Icon(Icons.visibility_rounded),
        label: const Text('Preview Statement'),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // AppRadius.borderRadiusMd
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
            Colors.white.withValues(alpha: .08),
          ),
        ),
      ),
    );
  }
}