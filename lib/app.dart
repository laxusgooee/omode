import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:omode/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => 
        PlatformTheme(
          themeMode: ThemeMode.system,
          materialDarkTheme: ThemeData(
            useMaterial3: true,
          ),
          builder: (context) => PlatformApp.router(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            title: 'Flutter Platform Widgets',
            routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}