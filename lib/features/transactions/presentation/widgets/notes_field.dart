import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int maxLength;

  const NotesField({
    super.key,
    required this.controller,
    this.onChanged,
    this.maxLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Icon(
            //   Icons.notes_rounded,
            //   size: 18,
            //   color: theme.colorScheme.primary,
            // ),
            const SizedBox(width: 8),
            Text(
              "Notes",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        TextField(
          controller: controller,
          maxLength: maxLength,
          maxLines: 4,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "Add a note (optional)",
            filled: true,
            fillColor: theme.colorScheme.surfaceContainer,
            counterText: "",
            contentPadding: const EdgeInsets.all(18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: theme.colorScheme.outlineVariant,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: theme.colorScheme.outlineVariant,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        Align(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) {
              return Text(
                "${value.text.length} / $maxLength",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}