import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketiq/shared/components/form/pocket_card_accent.dart';
import 'package:pocketiq/shared/components/form/pocket_card_accent_extension.dart';


class PocketInputCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final PocketCardAccent accent;
  final TextEditingController controller;
  final FocusNode? focusNode;

  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  final bool enabled;

  final String? hintText;

  const PocketInputCard({
    super.key,
    required this.title,
    required this.icon,
    required this.accent,
    required this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
    this.enabled = true,
    this.hintText,
  });

  @override
  State<PocketInputCard> createState() => _PocketInputCardState();
}

class _PocketInputCardState extends State<PocketInputCard> {
  bool _focused = false;

  FocusNode? _internalFocusNode;

  FocusNode get _focusNode {
    return widget.focusNode ??
        (_internalFocusNode ??= FocusNode());
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocus);

    _internalFocusNode?.dispose();

    super.dispose();
  }

  void _handleFocus() {
    if (mounted) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.accent.color(context);

    return FormField<String>(
      validator: widget.validator,
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
                      : _focused
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant
                      .withValues(alpha: .18),
                  width: _focused ? 2 : 1,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _focused
                          ? color.withValues(alpha: .24)
                          : color.withValues(alpha: .14),
                    ),
                    child: Icon(
                      widget.icon,
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
                          widget.title,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(
                            color: theme
                                .colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 4),

                        TextFormField(
                          controller: widget.controller,
                          focusNode: _focusNode,
                          enabled: widget.enabled,
                          keyboardType:
                          widget.keyboardType,
                          inputFormatters:
                          widget.inputFormatters,
                          textInputAction:
                          widget.textInputAction,
                          onFieldSubmitted:
                          widget.onFieldSubmitted,
                          style: theme
                              .textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -.2,
                          ),
                          decoration:
                          InputDecoration(
                            filled: false,
                            // fillColor: Colors.transparent,
                            isDense: true,
                            hintText: widget.hintText,
                            hintStyle: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: .45),
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                            enabledBorder:
                            InputBorder.none,
                            focusedBorder:
                            InputBorder.none,
                            disabledBorder:
                            InputBorder.none,
                            errorBorder:
                            InputBorder.none,
                            focusedErrorBorder:
                            InputBorder.none,
                            contentPadding:
                            EdgeInsets.zero,
                          ),
                          onChanged: (_) {
                            field.didChange(
                                widget.controller.text);
                          },
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