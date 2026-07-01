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
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    // TODO:
    // Firebase Authentication
    // Navigate to Home
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.huge),

                const AuthHeader(
                  title: 'Welcome Back',
                  subtitle:
                  'Manage your finances beautifully and effortlessly.',
                ),

                const SizedBox(height: AppSpacing.xxxl),

                PocketTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),

                const SizedBox(height: AppSpacing.lg),

                PocketPasswordField(
                  controller: _passwordController,
                  validator: Validators.password,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.push(
                        AppRoutes.forgotPassword,
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                PocketButton(
                  label: 'Sign In',
                  loading: auth.loading,
                  onPressed: _login,
                ),

                const SizedBox(height: AppSpacing.xl),

                AuthFooter(
                  text: "Don't have an account?",
                  actionText: 'Create Account',
                  onPressed: () {
                    context.push(
                      AppRoutes.register,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}