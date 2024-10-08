import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:calculator_app/config/router/app_router.dart';
import 'package:calculator_app/services/local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // tengo que colocar esto aquí para que funcione

  await LocalStorage.configurePrefs(); // aquí inicializamos sharedPreferences
  MobileAds.instance.initialize();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
