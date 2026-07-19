import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/constants/currencies.dart';
import '../../../../core/features/services/local_notification_service.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/cards/pocket_surface.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../../shared/components/inputs/setup_input_decoration.dart';
import '../../../../shared/layouts/pocket_gradient_scaffold.dart';
import '../providers/preferences_provider.dart';
import '../widgets/notification_permission_sheet.dart';
import '../widgets/setup_header.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
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
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = ref.read(preferencesProvider);

    await notifier.completeSetup(
      userName: _nameController.text.trim(),
      currencyCode: _selectedCurrency,
    );

    final permissionGranted =
    await LocalNotificationService.instance.isPermissionGranted();

    if (!permissionGranted) {
      if (!mounted) return;

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (_) =>
        const NotificationPermissionSheet(),
      );
    }

    if (!mounted) return;

    context.go(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(preferencesProvider);

    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PocketGradientScaffold(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),

                        const SetupHeader(
                          image: 'assets/images/setup/setup_1.png',
                          eyebrow: 'WELCOME',
                          title: 'PocketIQ',
                          subtitle:
                          "Let's personalize your finance journey.",
                        ),

                        const SizedBox(height: 40),

                        PocketSurface(
                          glow: true,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Name',
                                style: titleStyle,
                              ),

                              const SizedBox(height: 18),

                              PocketTextField(
                                controller: _nameController,
                                label: '',
                                hint: '',
                                validator: Validators.userName,
                                textInputAction:
                                TextInputAction.done,
                                decoration:
                                SetupInputDecoration.build(
                                  context,
                                  hint: 'Enter your name',
                                ),
                                onFieldSubmitted: (_) =>
                                    _continue(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        PocketSurface(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preferred Currency',
                                style: titleStyle,
                              ),

                              const SizedBox(height: 18),

                              PocketDropdown<String>(
                                label: '',
                                value: _selectedCurrency,
                                enabled: false,
                                decoration:
                                SetupInputDecoration.build(
                                  context,
                                  hint:
                                  'Choose your currency',
                                ),
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
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: AppSpacing.screenPadding,
                  child: PocketButton(
                    label: 'Continue',
                    loading: notifier.loading,
                    onPressed: _continue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}