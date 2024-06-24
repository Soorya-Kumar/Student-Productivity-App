import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/add_new_task.dart';
import 'package:fusion_ease_app/to-do_list/scroll_list_TODO.dart';


final user = FirebaseAuth.instance.currentUser!.uid;

class TODOLandingPage extends StatelessWidget {
  const TODOLandingPage({super.key});


  final int noofPendingTask = 0;

  void deleteAllFunc() async {
    await FirebaseFirestore.instance
        .collection(user)
        .doc('TODO-ITEMS')
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'TO DO LIST',
          style: TextStyle(color: Colors.white),
        ),
        actions: [

          IconButton(
            icon: const Icon(Icons.delete_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Clear All Tasks'),
                    content: const Text('Are you sure you want to clear all tasks?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FilledButton(
                        child: const Text('Clear'),
                        onPressed: () {
                          deleteAllFunc();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

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
