import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mystate extends StatelessWidget {
  const mystate({super.key});

  @override
  Widget build(BuildContext context) {
  final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

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
                child: Text('SOEMTHING WENT WRONG..'),
              ),
            );
          }

      if (!snapshots.hasData || !snapshots.data!.exists || snapshots.data!.data() == null){
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

              final TaskData = tasks[index];

              return ListTile(
                title: Text( TaskData['title'],),
                subtitle: Text(TaskData['date'].toString(),),
                trailing: Checkbox(
                  value:  TaskData['status'],
                  onChanged: (bool? value) {},
                ),
              );
            },
          );
        });
  }
}
