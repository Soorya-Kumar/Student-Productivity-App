import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/daily_planner/provider.dart';

class ManageDailyy extends ConsumerWidget {
  const ManageDailyy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyPlannerState = ref.watch(dailyPlannerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Manage Daily Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetTasksDialog(context, ref),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dailyPlannerState.dailyPlanner.length,
        itemBuilder: (context, index) {
          int hour = index;
          String displayTime;

          if (hour == 0) {
            displayTime = "12 AM";
          } else if (hour < 12) {
            displayTime = "$hour AM";
          } else if (hour == 12) {
            displayTime = "12 PM";
          } else {
            displayTime = "${hour - 12} PM";
          }

          return Container(
            padding: const EdgeInsets.all(8),            
            color: dailyPlannerState.isTaskCompleted[index] ? Colors.lightGreen[100] : Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(displayTime, style: const TextStyle(fontSize: 16),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          dailyPlannerState.dailyPlanner[index],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueGrey, size: 20),
                          onPressed: () => ref.read(dailyPlannerProvider.notifier).addParticularTask(context,index),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.blueGrey, size: 20),
                          onPressed: () => ref.read(dailyPlannerProvider.notifier).clearParticularTask(index),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(color: Theme.of(context).colorScheme.primary.withOpacity(0.9),indent: 8,endIndent: 8,),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _resetTasksDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Tasks'),
          content: const Text('Are you sure you want to reset all tasks?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                ref.read(dailyPlannerProvider.notifier).resetTasks();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    int selectedHour = 0;
    String task = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: selectedHour,
                onChanged: (value) => selectedHour = value ?? 0,
                items: List.generate(24, (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text('${index.toString().padLeft(2, '0')}:00'),
                )),
                decoration: const InputDecoration(labelText: 'Hour'),
              ),
              TextField(
                onChanged: (value) => task = value,
                decoration: const InputDecoration(labelText: 'Task'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(dailyPlannerProvider.notifier).addTask(selectedHour, task);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
