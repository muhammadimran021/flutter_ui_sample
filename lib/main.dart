import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ui_sample/UI/screens/main_page/MainPageProvider.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:flutter_ui_sample/routes/route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'UI/screens/home_page/home_provider.dart';
import 'constants/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupFirebaseConfigs();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  /*runApp(
    DevicePreview(
      enabled: true, // Enable preview
      builder:
          (context) => EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar')],
            path: 'lib/assets/translations',
            fallbackLocale: Locale('en'),
            child: const MyApp(),
          ), // Your app widget
    ),
  );*/

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
      ],

      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'lib/assets/translations',
        fallbackLocale: Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> _setupFirebaseConfigs() async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      /*builder: DevicePreview.appBuilder,*/
      routerConfig: route,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(primary: AppColors.whiteColor),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            // iOS-like
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.nunitoSans(
            fontSize: 20,
            fontWeight: FontWeights.boldFontWeight,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          bodyMedium: GoogleFonts.nunitoSans(
            fontSize: 12,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
    );
  }
}
