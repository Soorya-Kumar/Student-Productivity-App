import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/status_bar_widget.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

class ScrollListTODO extends StatefulWidget {
  const ScrollListTODO({super.key});

  @override
  State<ScrollListTODO> createState() => _ScrollListTODOState();
}

class _ScrollListTODOState extends State<ScrollListTODO> {

  int totalTasks = 0;
/*
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection(_currAppUser)
        .doc('TODO-ITEMS')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        List tasks = snapshot.data()!['tasks'];
        if (tasks.length != totalTasks) {
          setState(() {
            totalTasks = tasks.length;
          });
        }
      }
    });
  }
*/
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


  Color? _colorGiver(String priority){
    if(priority == 'high')
    {
      return Colors.red[100];
    }
    else if(priority == 'medium')
    {
      return Colors.yellow[100];
    }
    else
    {
      return Colors.green[100];
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatusBarTop(noofPendingTask: totalTasks),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
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
                totalTasks = tasks.length;
                

                return ListView.builder(
                  itemCount: tasks.length,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final taskData = tasks[index];

                    return ListTile(
                      tileColor: _colorGiver(taskData['priority']),
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
              }),
        ),
      ],
    );
  }
}