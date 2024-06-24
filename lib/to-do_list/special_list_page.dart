import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/to-do_list/todo_functions.dart';

class SpecialTasksPage extends ConsumerWidget {
  const SpecialTasksPage({super.key, required this.refer, required this.dummy});

  final AutoDisposeProvider<List<dynamic>> refer;
  final String dummy;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialTasks = ref.watch(refer);

    if (specialTasks.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: Colors.blue[50],
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(dummy),
              const SizedBox(
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
          final taskData = specialTasks[index];
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
        childCount: specialTasks.length,
      ),
    );
  }
}
