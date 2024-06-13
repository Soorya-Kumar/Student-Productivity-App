import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

class ScrollListTODO extends StatefulWidget {
  const ScrollListTODO({super.key});

  @override
  State<ScrollListTODO> createState() => _ScrollListTODOState();
}

class _ScrollListTODOState extends State<ScrollListTODO> {
  void deleteTask(taskData, int index){
    FirebaseFirestore.instance
        .collection(_currAppUser)
        .doc('TODO-ITEMS')
        .update({
      'tasks': FieldValue.arrayRemove([taskData])
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: const Text('Task successfully completed'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
        FirebaseFirestore.instance
          .collection(_currAppUser)
          .doc('TODO-ITEMS')
          .update({'tasks': FieldValue.arrayUnion([taskData])});
        },
      ),
      ),
    );

     
  }

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(_currAppUser)
            .doc('TODO-ITEMS')
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
                child: Text('No tasks found'),
              ),
            );
          }

          List tasks = snapshots.data!['tasks'];

          return ListView.builder(
            itemCount: tasks.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final taskData = tasks[index];

              return ListTile(
                title: Text(
                  taskData['title'],
                ),
                subtitle: Text(
                  taskData['date'].toString(),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    deleteTask(taskData, index);
                  },
                ),
              );
            },
          );
        });
  }
}
