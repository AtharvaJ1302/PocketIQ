import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/constants/currencies.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../providers/preferences_provider.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() =>
      _SetupScreenState();
}

class _SetupScreenState
    extends ConsumerState<SetupScreen> {

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  String _selectedCurrency = Currencies.inr;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final notifier =
    ref.read(preferencesProvider);

    await notifier.completeSetup(
      userName: _nameController.text.trim(),
      currencyCode: _selectedCurrency,
    );

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {

    final notifier = ref.watch(preferencesProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    'Welcome 👋',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
                  ),

                  const SizedBox(
                    height: AppSpacing.sm,
                  ),

                  Text(
                    "Let's personalize your experience.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge,
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  PocketTextField(
                    controller: _nameController,
                    label: 'Your Name',
                    hint: 'John Doe',
                    validator: Validators.userName,
                    textInputAction:
                    TextInputAction.done,
                    onFieldSubmitted: (_) =>
                        _continue(),
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  PocketDropdown<String>(
                    label: 'Preferred Currency',
                    value: _selectedCurrency,
                    enabled: false,
                    items: Currencies.supported
                        .map(
                          (currency) =>
                          DropdownMenuItem(
                            value: currency,
                            child: Text(
                              Currencies.getName(
                                currency,
                              ),
                            ),
                          ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedCurrency =
                            value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  PocketButton(
                    label: 'Continue',
                    loading: notifier.loading,
                    onPressed: _continue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}