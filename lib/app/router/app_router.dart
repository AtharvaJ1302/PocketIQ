import 'package:go_router/go_router.dart';
import 'package:pocketiq/features/settings/presentations/screens/settings_screen.dart';
import 'package:pocketiq/features/transactions/presentation/screens/transaction_form_screen.dart';

import '../../features/accounts/domain/models/account.dart';
import '../../features/accounts/presentation/screens/account_form_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/budget/presentation/screens/budget_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/navigation/presentation/screens/main_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/security/presentation/screens/app_lock_screen.dart';
import '../../features/setup/presentation/screens/setup_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/accounts/presentation/screens/accounts_screen.dart';
import '../../features/statement/presentation/screens/statement_preview_screen.dart';
import '../../features/statement/presentation/screens/statement_screen.dart';
import '../../features/transactions/presentation/models/transaction_form_args.dart';
import '../../features/transactions/presentation/models/transactions_screen_args.dart';
import '../../features/transactions/presentation/screens/transactions_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      // Authentication Routes

      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
          path: AppRoutes.login,
          builder: (_, __) => const LoginScreen()
      ),

      // Onboarding Routes

      GoRoute(
          path: AppRoutes.splash,
          builder: (_, __) => const SplashScreen()
      ),
      GoRoute(
          path: AppRoutes.onboarding,
          builder: (_, __) => const OnboardingScreen()
      ),

      // Home Routes

    GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => const HomeScreen()
      ),
    GoRoute(
          path: AppRoutes.analytics,
          builder: (_, __) => const AnalyticsScreen()
      ),
    GoRoute(
          path: AppRoutes.budget,
          builder: (_, __) => const BudgetScreen()
      ),
    GoRoute(
          path: AppRoutes.settings,
          builder: (_, __) => const SettingsScreen()
      ),
      GoRoute(
        path: AppRoutes.setup,
        builder: (_, __) => const SetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (_, __) => const MainScreen(),
      ),

      //Accounts Routes

      GoRoute(
        path: AppRoutes.accounts,
        builder: (context, state) => const AccountsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addAccount,
        builder: (context, state) {
          return AccountFormScreen(
            account: state.extra as Account?,
          );
        },
      ),

      //Transactions Routes
      GoRoute(
        path: AppRoutes.transactions,
        builder: (context, state) {
          return TransactionsScreen(
            args: state.extra as TransactionsScreenArgs?,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (context, state) {
          final args = state.extra as TransactionFormArgs?;

          return TransactionFormScreen(
            args: args,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.appLock,
        builder: (_, __) => const AppLockScreen(),
      ),

      //Statement Route
      GoRoute(
        path: AppRoutes.statement,
        builder: (_, __) =>
        const StatementScreen(),
      ),
    ],
  );
}
