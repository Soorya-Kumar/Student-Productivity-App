import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/notes_subapp/view_note.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

class ScrollListNOTES extends StatefulWidget {
  const ScrollListNOTES({super.key});

  @override
  State<ScrollListNOTES> createState() => _ScrollListNOTESState();
}

class _ScrollListNOTESState extends State<ScrollListNOTES> {

  List lightColors = [
    const Color.fromARGB(255, 235, 221, 175),
    Colors.white,
    const Color.fromARGB(255, 196, 231, 155),
    const Color.fromARGB(255, 160, 213, 237),
    const Color.fromARGB(255, 233, 199, 148),
    const Color.fromARGB(255, 245, 204, 218),
    const Color.fromARGB(255, 169, 240, 223),
    const Color.fromARGB(255, 227, 166, 237),
    const Color.fromARGB(255, 166, 242, 205),
    const Color.fromARGB(255, 146, 226, 226),
  ];

  @override
  Widget build(BuildContext context) {
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(_currAppUser)
                    .doc('NOTES')
                    .snapshots(),
                builder: (ctx, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
          
                  if (snapshots.hasError) {
                    return const Scaffold(
                      body: Center(
                        child: Text('SOMETHING WENT WRONG..'),
                      ),
                    );
                  }
          
                  if (!snapshots.hasData ||
                      !snapshots.data!.exists ||
                      snapshots.data!.data() == null) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Add a new note'),
                      ),
                    );
                  }
          
                  List notes = snapshots.data!['notes'];

                  return GridView.builder(
                    itemCount: notes.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      final noteData = notes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SingleNotePage(noteData: noteData)));
                        },
                        child: Card(
                          color: lightColors[noteData['color']],
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                noteData['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    noteData['date'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    noteData['msg'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 9, 8, 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ],
    );
  }
}