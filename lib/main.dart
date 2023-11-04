import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:jezt_news/Navbar/navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? ThemeData.dark() : ThemeData.light();
    return ThemeProvider(
        initTheme: initTheme,
        builder: (_, myTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JEZT News',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
              useMaterial3: true,
            ),
            home: AnimatedSplashScreen(
                duration: 2000,
                backgroundColor: Colors.lightBlueAccent.shade100,
                splashTransition: SplashTransition.scaleTransition,
                splash: const Icon(
                  Icons.newspaper_rounded,
                  size: 100,
                  color: Colors.white,
                ),
                nextScreen: const NavBar()),
          );
        });
  }
}
