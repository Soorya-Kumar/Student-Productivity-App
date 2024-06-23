import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/to-do_list/todo_functions.dart';
import 'package:fusion_ease_app/to-do_list/todo_provider.dart';

class OverDueTasks extends ConsumerWidget {
  const OverDueTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overDueTasks = ref.watch(overdueTasksProvider);

    if (overDueTasks.isEmpty) {
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
              Text('No pending tasks!! GOOD JOB!!'),
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
          final taskData = overDueTasks[index];
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
        childCount: overDueTasks.length,
      ),
    );
  }
}
