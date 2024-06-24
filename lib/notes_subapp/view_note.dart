import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/notes_subapp/colors_provider.dart';
import 'package:fusion_ease_app/notes_subapp/edit_note.dart';

final currentUser = FirebaseAuth.instance.currentUser!;

class SingleNotePage extends StatelessWidget {
  const SingleNotePage({Key? key, required this.noteData}) : super(key: key);

  final Map<String, dynamic> noteData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          noteData['title'],
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: [

          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return EditNote(
                      noteData: noteData,
                    );
                  },
                ),
              );
            },
            
          ),


          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection(currentUser.uid)
                  .doc('NOTES')
                  .update({
                'notes': FieldValue.arrayRemove([noteData])
              });

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Note successfully deleted'),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection(currentUser.uid)
                          .doc('NOTES')
                          .update({
                        'notes': FieldValue.arrayUnion([noteData])
                      });
                    },
                  ),
                ),
              );
              Navigator.of(context).pop();
            },
          ),

          
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: lightColors[noteData['color']],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            noteData['msg'],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
