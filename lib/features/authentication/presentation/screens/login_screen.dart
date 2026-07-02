import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/inputs/pocket_password_field.dart';
import '../../../../shared/components/inputs/pocket_text_button.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../providers/authentication_provider.dart';
import '../widgets/auth_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    // TODO:
    // authenticationNotifier.login(...)
    // context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AuthLayout(
          title: 'Welcome Back',
          subtitle:
          'Manage your finances beautifully and effortlessly.',
          footerText: "Don't have an account?",
          footerActionText: 'Create Account',
          onFooterPressed: () {
            context.push(AppRoutes.register);
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PocketTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                  onFieldSubmitted: (_) {
                    _passwordFocusNode.requestFocus();
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                PocketPasswordField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: Validators.password,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: PocketTextButton(
                    label: 'Forgot Password?',
                    onPressed: () {
                      context.push(
                        AppRoutes.forgotPassword,
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                PocketButton(
                  label: 'Sign In',
                  loading: auth.loading,
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}