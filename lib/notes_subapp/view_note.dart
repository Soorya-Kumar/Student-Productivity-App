import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/notes_subapp/edit_note.dart';

final currentUser = FirebaseAuth.instance.currentUser!;

class SingleNotePage extends StatelessWidget {
  SingleNotePage({Key? key, required this.noteData}) : super(key: key);

  final Map<String, dynamic> noteData;

  final lightColors = [
    Colors.amber.shade300,
    Colors.white,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 121, 51, 243),
        title: Text(
          noteData['title'],
          style: const TextStyle(color: Colors.white),
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
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
