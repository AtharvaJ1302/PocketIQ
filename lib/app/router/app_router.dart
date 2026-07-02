import 'package:go_router/go_router.dart';

import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/budget/presentation/screens/budget_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/transactions/presentation/screens/transactions_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
          path: AppRoutes.splash,
          builder: (_, __) => const SplashScreen()
      ),
    GoRoute(
          path: AppRoutes.onboarding,
          builder: (_, __) => const OnboardingScreen()
      ),
     GoRoute(
          path: AppRoutes.login,
          builder: (_, __) => const LoginScreen()
      ),
    GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => const HomeScreen()
      ),
    GoRoute(
          path: AppRoutes.transactions,
          builder: (_, __) => const TransactionsScreen()
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
          path: AppRoutes.profile,
          builder: (_, __) => const ProfileScreen()
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
    ],
  );
}
