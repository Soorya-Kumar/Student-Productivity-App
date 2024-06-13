import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FUsION EAsE'),
        ),
        body: const Column(
          children: [
            CircularProgressIndicator(),
            Text("Loading IN.. Please Wait..."),
          ],
        ),
      ),
    );
  }
}
