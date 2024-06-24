import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/firebase_options.dart';
import 'package:fusion_ease_app/screens/login_screen.dart';
import 'package:fusion_ease_app/screens/main_home_screen.dart';
import 'package:fusion_ease_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const ProviderScope(child: MyApp()));
}

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(20,110,180, 255),
  ),
  useMaterial3: true,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
      
            if (snapshot.hasData) {
              return const MainHomeScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
