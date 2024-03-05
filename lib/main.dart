// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_admin/app/modules/login/onboarding/onboarding_screen.dart';
import 'package:flutter_admin/firebase_options.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Intl.defaultLocale = 'lo_LA';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // เพิ่ม Localizations เพิ่มเติมตามความเหมาะสม
      ],
      supportedLocales: [
        const Locale('en', 'US'), // ภาษาอังกฤษ
        const Locale('lo', 'LA'), // ภาษาลาว
        // เพิ่ม Locale เพิ่มเติมตามความเหมาะสม
      ],


      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('lo', 'LA'),
      //   Locale('en'),
      // ],
      home: const OnboardingScreen(),
    );
  }
}
