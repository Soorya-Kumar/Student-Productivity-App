import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/to-do_list/todo_functions.dart';
import 'package:fusion_ease_app/to-do_list/todo_provider.dart';

class TodayTasksPage extends ConsumerWidget {
  const TodayTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTasks = ref.watch(todayTasksProvider);

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
              Text(
                  'No tasks today !!!\nBut you can always do tomorrow\'s tasks'),
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
  }
}
