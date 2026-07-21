import 'package:flutter/material.dart';

class PocketSelectItem<T> {
  final T value;
  final String title;
  final String? subtitle;
  final Widget? leading;

  const PocketSelectItem({
    required this.value,
    required this.title,
    this.subtitle,
    this.leading,
  });
}

class PocketSelect<T> extends StatefulWidget {
  final T? value;
  final List<PocketSelectItem<T>> items;
  final ValueChanged<T> onChanged;
  final String hint;

  const PocketSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  State<PocketSelect<T>> createState() => _PocketSelectState<T>();
}

class _PocketSelectState<T> extends State<PocketSelect<T>> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlay;

  bool get _isOpen => _overlay != null;

  PocketSelectItem<T>? get _selectedItem {
    for (final item in widget.items) {
      if (item.value == widget.value) {
        return item;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selected = _selectedItem;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Overlay will be implemented next.
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              children: [

                if (selected?.leading != null)
                  selected!.leading!
                else
                  Icon(
                    Icons.account_balance_rounded,
                    color: theme.colorScheme.primary,
                  ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        selected?.title ?? widget.hint,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      if (selected?.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          selected!.subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                AnimatedRotation(
                  turns: _isOpen ? .5 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(Icons.expand_more_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}