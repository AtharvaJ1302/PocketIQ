import 'package:flutter/material.dart';
import 'package:pocketiq/shared/components/cards/pocket_surface.dart';
import '../../../app/theme/colors/app_colors.dart';


class PocketInputCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const PocketInputCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return PocketSurface(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(
                    dark ? .15 : .08,
                  ),
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),

              const SizedBox(width: 14),

              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          child,
        ],
      ),
    );
  }
}