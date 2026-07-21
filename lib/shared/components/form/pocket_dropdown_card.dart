import 'package:flutter/material.dart';
import 'package:pocketiq/shared/components/form/pocket_card_accent.dart';
import 'package:pocketiq/shared/components/form/pocket_card_accent_extension.dart';

class PocketDropdownCard<T> extends StatelessWidget {
  final String title;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  final IconData icon;
  final PocketCardAccent accent;
  final bool enabled;
  final String? hint;

  const PocketDropdownCard({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.icon,
    required this.accent,
    this.validator,
    this.enabled = true,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = accent.color(context);

    return FormField<T>(
      initialValue: value,
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: field.hasError
                      ? theme.colorScheme.error
                      : theme.colorScheme.outlineVariant
                      .withValues(alpha: .18),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 32,
                    spreadRadius: -6,
                    offset: const Offset(0, 14),
                    color: Colors.black.withValues(alpha: .10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: .14),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(
                            color: theme.colorScheme
                                .onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 4),

                        DropdownButtonHideUnderline(
                          child: DropdownButton<T>(
                            value: value,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),

                            hint: Text(
                              hint ?? 'Select',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),

                            items: items,
                            onChanged: enabled
                                ? (newValue) {
                              field.didChange(newValue);
                              onChanged?.call(newValue);
                            }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 8,
                ),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}