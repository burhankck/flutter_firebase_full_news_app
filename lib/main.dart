import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_news_app/future/splash/splash_view.dart';
import 'package:flutter_firebase_full_news_app/product/constants/string_constants.dart';
import 'package:flutter_firebase_full_news_app/product/initialize/application_start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home:   SplashView(),
    );
  }
}
