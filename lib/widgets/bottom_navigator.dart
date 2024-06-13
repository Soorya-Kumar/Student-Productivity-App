import 'package:flutter/material.dart';
import 'package:fusion_ease_app/screens/main_home_screen.dart';
import 'package:fusion_ease_app/to-do_list/landing_page.dart';

class BootomBar extends StatefulWidget{
  const BootomBar({super.key, required this.selectedpage});

  final int selectedpage;

  @override
  State<BootomBar> createState() => _BootomBarState();
}

class _BootomBarState extends State<BootomBar> {

  final List<dynamic> _pages = [
    const MainHomeScreen(),
    const TODOLandingPage(),
    const MainHomeScreen(),
    const MainHomeScreen(),
    const MainHomeScreen(),
  ];

  void _changeselectpage(int index) {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => _pages[index],),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.selectedpage,
        selectedItemColor: const Color.fromARGB(255, 248, 248, 248),
        unselectedItemColor: const Color.fromARGB(255, 205, 205, 205),
        type: BottomNavigationBarType.shifting,
        onTap: _changeselectpage,

        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 121, 51, 243),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 121, 51, 243),
            icon: Icon(Icons.check_box_rounded),
            label: 'To-do',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 121, 51, 243),
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Grocery List',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 121, 51, 243),
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 141, 76, 254),
            icon: Icon(Icons.attach_money_rounded),
            label: 'Expense Tracker',
          ),/*BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 141, 76, 254),
            icon: Icon(Icons.sports_basketball_rounded),
            label: 'Game',
          ),*/
        ],
      );
  }
}