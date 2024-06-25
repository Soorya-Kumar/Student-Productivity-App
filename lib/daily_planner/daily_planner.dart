import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/daily_planner/manage_planner.dart';
import 'package:fusion_ease_app/daily_planner/provider.dart';

class DailyPlannerScreen extends ConsumerWidget {
  const DailyPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyPlannerState = ref.watch(dailyPlannerProvider);
    final allottedTasks = dailyPlannerState.dailyPlanner
        .asMap()
        .entries
        .where((entry) => entry.value.isNotEmpty)
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('Daily Planner'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Reset Tasks'),
                      content:
                          const Text('Are you sure you want to reset all tasks?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
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
              },
            ),
          ],
        ),
    
        body: allottedTasks.isNotEmpty
            ? ListView.builder(
                itemCount: allottedTasks.length,
                itemBuilder: (context, index) {
                  final entry = allottedTasks[index];
                  int hour = entry.key + 5;
    
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: dailyPlannerState.isTaskCompleted[entry.key]
                        ? Colors.green[100]
                        : Colors.grey[200],
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$hour:00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dailyPlannerState.isTaskCompleted[entry.key]
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 8), 
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              value: dailyPlannerState.isTaskCompleted[entry.key],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  ref
                                      .read(dailyPlannerProvider.notifier)
                                      .toggleTaskCompletion(entry.key, value);
                                }
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('Start planning your day to see it here')),
    
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageDaily()));
            },
            icon: const Icon(Icons.edit_rounded),
            label: const Text("Manage Schedule"),
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    int selectedHour = 5;
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
                onChanged: (value) {
                  if (value != null) {
                    selectedHour = value;
                  }
                },
                items: List.generate(19, (index) => index + 5)
                    .map((hour) => DropdownMenuItem<int>(
                          value: hour,
                          child: Text('$hour:00'),
                        ))
                    .toList(),
              ),
              TextField(
                onChanged: (value) {
                  task = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Task',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref
                    .read(dailyPlannerProvider.notifier)
                    .addTask(selectedHour, task);
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
