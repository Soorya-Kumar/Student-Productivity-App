import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/to-do_list/todo_functions.dart';
import 'package:fusion_ease_app/to-do_list/status_bar_widget.dart';
import 'package:fusion_ease_app/to-do_list/todo_provider.dart';

class ScrollListTODO extends ConsumerWidget {
  const ScrollListTODO({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasks = ref.watch(tasksProvider).asData?.value ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatusBarTop(noofPendingTask: tasks.length),
        const SizedBox(
          height: 10,
        ),
        
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final taskData = tasks[index];
        
              return ListTile(
                tileColor: colorGiver(taskData['priority']),
                title: Text(
                  taskData['title'],
                ),
                subtitle: Text(
                  taskData['date'].toString(),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    deleteTask(taskData, index, context);
                  },
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}
