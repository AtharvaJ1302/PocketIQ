import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/inputs/pocket_password_field.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../providers/authentication_provider.dart';
import '../widgets/auth_layout.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _nameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmPasswordFocus;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();

    super.dispose();
  }

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AuthLayout(
          title: 'Create Account',
          subtitle: 'Start your financial journey with PocketIQ.',
          footerText: 'Already have an account?',
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
                  controller: _nameController,
                  focusNode: _nameFocus,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  textCapitalization: TextCapitalization.words,
                  validator: Validators.name,
                  prefixIcon: const Icon(Icons.person_outline),
                  onFieldSubmitted: (_) {
                    _emailFocus.requestFocus();
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                PocketTextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                  onFieldSubmitted: (_) {
                    _passwordFocus.requestFocus();
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                PocketPasswordField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  validator: Validators.password,
                  onFieldSubmitted: (_) {
                    _confirmPasswordFocus.requestFocus();
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                PocketPasswordField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  label: 'Confirm Password',
                  validator: (value) => Validators.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _register(),
                ),

                const SizedBox(height: AppSpacing.xl),

                PocketButton(
                  label: 'Create Account',
                  loading: auth.loading,
                  onPressed: _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}