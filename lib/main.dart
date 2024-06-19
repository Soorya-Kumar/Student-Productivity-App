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

//Platform  Firebase App Id
//android   1:172407271569:android:0978ff29ce8b7e5ed50f30
//ios       1:172407271569:ios:bc5324272497eae1d50f30

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 100, 11, 255),
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
