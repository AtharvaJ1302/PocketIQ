import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';

class EditNameSheet extends ConsumerStatefulWidget {
  const EditNameSheet({
    super.key,
  });

  @override
  ConsumerState<EditNameSheet> createState() =>
      _EditNameSheetState();
}

class _EditNameSheetState
    extends ConsumerState<EditNameSheet> {

  final _formKey =
  GlobalKey<FormState>();

  late final TextEditingController
  _controller;

  @override
  void initState() {
    super.initState();

    final preferences =
        ref.read(
          preferencesProvider,
        ).preferences;

    _controller = TextEditingController(
      text: preferences.userName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newName = _controller.text.trim();

    final currentName =
        ref.read(preferencesProvider).preferences.userName;

    if (newName == currentName) {
      Navigator.pop(context);
      return;
    }

    await ref
        .read(preferencesProvider)
        .updateUserName(newName);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final notifier =
    ref.watch(
      preferencesProvider,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [

          PocketTextField(
            controller: _controller,
            label: 'Your Name',
            hint: 'John Doe',
            validator:
            Validators.userName,
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          PocketButton(
            label: 'Save',
            loading:
            notifier.loading,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}