import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/widgets/bottom_navigator.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() {
    return _MainHomeScreen();
  }
}

class _MainHomeScreen extends State<MainHomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 121, 51, 243),
        title: const Text(
          'FUsION EAsE',
          style: TextStyle(color: Colors.white),
        ),
        
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
            color: Colors.white,
          )
        ],
      ),
      
      body: const Text('Main Home Screen'),
      
      bottomNavigationBar: const BootomBar(selectedpage: 0,),
    );
  }
}
