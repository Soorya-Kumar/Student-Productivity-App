import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/functions.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

class TodayTasksPage extends StatelessWidget {
  const TodayTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String today =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(_currAppUser)
          .doc('TODO-ITEMS')
          .snapshots(),
      builder: (ctx, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshots.hasError) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('SOMETHING WENT WRONG..')),
          );
        }

        if (!snapshots.hasData ||
            !snapshots.data!.exists ||
            snapshots.data!.data() == null) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No tasks found')),
          );
        }

        List tasks = snapshots.data!['tasks'];
        List todayTasks = tasks.where((task) {
          return task['date'].toString().substring(0, 10) == today;
        }).toList();

        if (todayTasks.isEmpty) {
          return SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: Colors.deepPurple[50],
              alignment: Alignment.center,
              child: const Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('No tasks today !!!\nBut you can always do tomorrow\'s tasks'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              
            ),
          );
        }
        
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final taskData = todayTasks[index];
              return ListTile(
                tileColor: colorGiver(taskData['priority']),
                title: Text(taskData['title']),
                subtitle: Text(taskData['date'].toString()),
                trailing: Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    deleteTask(taskData, index, context);
                  },
                ),
              );
            },
            childCount: todayTasks.length,
          ),
        );
      },
    );
  }
}