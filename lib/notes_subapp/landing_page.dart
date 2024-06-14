import 'package:flutter/material.dart';
import 'package:fusion_ease_app/notes_subapp/add_new_note.dart';
import 'package:fusion_ease_app/notes_subapp/scroll_list_widget.dart';

class NotesLandingPage extends StatelessWidget {
  const NotesLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 121, 51, 243),
        title: const Text(
          'NOTES',
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
      body: const ScrollListNOTES(),
    );
  }
}
