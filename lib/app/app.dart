import 'package:flutter/material.dart';

import 'theme/themes/app_theme.dart';

class PocketIQApp extends StatelessWidget{
  const PocketIQApp({super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'PocketIQ',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: ThemeMode.system,

      home: const Scaffold(
        body: Center(
          child: Text("PocketIQ"),
        ),
      )
    );
  }
}