import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/add_new_task.dart';
import 'package:fusion_ease_app/to-do_list/scroll_list_widget.dart';

class TODOLandingPage extends StatelessWidget {
  const TODOLandingPage({super.key});

  final int noofPendingTask = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 121, 51, 243),
        title: const Text(
          'TO DO LIST',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNewItem()),
              );
            },
          ),
        ],
      ),
      body: const ScrollListTODO(),
    );
  }
}
