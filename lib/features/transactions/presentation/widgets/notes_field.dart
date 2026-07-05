import 'package:flutter/material.dart';

import '../../../../shared/components/inputs/pocket_text_field.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const NotesField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return PocketTextField(
      controller: controller,
      focusNode: focusNode,
      label: 'Notes',
      hint: 'Optional',
      prefixIcon: const Icon(Icons.notes_outlined),
      textInputAction: TextInputAction.done,
      maxLines: 3,
    );
  }
}