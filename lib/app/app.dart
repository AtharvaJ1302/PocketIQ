import 'package:flutter/material.dart';
import 'package:pocketiq/app/router/app_router.dart';

import 'theme/themes/app_theme.dart';

class PocketIQApp extends StatelessWidget{
  const PocketIQApp({super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'PocketIQ',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: ThemeMode.system,

      routerConfig: AppRouter.router,
    );
  }
}