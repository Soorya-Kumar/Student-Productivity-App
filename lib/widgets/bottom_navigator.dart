import 'package:flutter/material.dart';
import 'package:fusion_ease_app/add-subapp/landing_page.dart';
import 'package:fusion_ease_app/daily_planner/daily_planner.dart';
import 'package:fusion_ease_app/notes_subapp/landing_page.dart';
import 'package:fusion_ease_app/screens/main_home_screen.dart';
import 'package:fusion_ease_app/to-do_list/landing_page.dart';

class BootomBar extends StatefulWidget{
  const BootomBar({super.key, required this.selectedpage});

  final int selectedpage;
  @override
  State<BootomBar> createState() => _BootomBarState();
}

class _BootomBarState extends State<BootomBar> {

  late List<dynamic> _pages;

  @override
  void initState() {
    _pages = [
      const MainHomeScreen(),
      const TODOLandingPage(),
      const NotesLandingPage(),
      const DailyPlannerScreen(),
      const ADDTLandingPage(),
    ];
    super.initState();
  }
  

  void _changeselectpage(int index) {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => _pages[index],),);
    });
  }

  @override
  Widget build(BuildContext context) {

    Color color =  Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7);

    return BottomNavigationBar(
        currentIndex: widget.selectedpage,
        selectedItemColor: const Color.fromARGB(255, 248, 248, 248),
        unselectedItemColor: const Color.fromARGB(255, 205, 205, 205),
        type: BottomNavigationBarType.shifting,
        onTap: _changeselectpage,

        items: [
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: const Icon(Icons.check_box_rounded),
            label: 'To-do',
          ),
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: const Icon(Icons.book_rounded),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: const Icon(Icons.calendar_today_rounded),
            label: 'Daily Planner',
          ),
          /*
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 141, 76, 254),
            icon: Icon(Icons.attach_money_rounded),
            label: 'Podoromo Timer',
          ),*/BottomNavigationBarItem(
            backgroundColor: color,
            icon: const Icon(Icons.assessment_rounded),
            label: 'Addentance Tracker',
          ),/*BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 141, 76, 254),
            icon: Icon(Icons.sports_basketball_rounded),
            label: 'Game',
          ),*/
        ],
      );
  }
}