import 'package:pocketiq/app/router/app_routes.dart';

class StartupService {
  StartupService._();

  static Future<String> getInitialRoute() async{
    //TODO:
    //Check onboarding
    //check authentication
    //check biometrics

    return AppRoutes.onboarding;
  }
}