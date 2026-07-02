import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../providers/authentication_provider.dart';
import '../widgets/auth_layout.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _resetPassword() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset link sent (Demo)',
        ),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AuthLayout(
          title: 'Forgot Password',
          subtitle:
          'Enter your registered email to receive a password reset link.',
          footerText: 'Remember your password?',
          footerActionText: 'Sign In',
          onFooterPressed: () {
            context.pop();
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PocketTextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: Validators.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                  onFieldSubmitted: (_) => _resetPassword(),
                ),

                const SizedBox(height: AppSpacing.xl),

                PocketButton(
                  label: 'Reset Password',
                  loading: auth.loading,
                  onPressed: _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}