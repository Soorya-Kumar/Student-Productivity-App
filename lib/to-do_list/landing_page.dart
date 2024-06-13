import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/add_new_task.dart';
import 'package:fusion_ease_app/to-do_list/scroll_list_widget.dart';
import 'package:fusion_ease_app/to-do_list/status_bar_widget.dart';

class TODOLandingPage extends StatefulWidget {
  const TODOLandingPage({super.key});

  @override
  State<TODOLandingPage> createState() {
    return _TODOLandingPage();
  }
}

class _TODOLandingPage extends State<TODOLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('TO DO LIST'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNewItem()),
              );
            },
          ),
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusBarTop(),
          SizedBox(
            height: 10,
          ),
          Expanded(child: ScrollListTODO()),
        ],
      ),
    );
  }
}
