import 'package:flutter/material.dart';
import 'package:fusion_ease_app/notes_subapp/add_new_note.dart';
import 'package:fusion_ease_app/notes_subapp/scroll_list_widget.dart';

class NotesLandingPage extends StatelessWidget {
  const NotesLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
      ),
    );
  }
}
