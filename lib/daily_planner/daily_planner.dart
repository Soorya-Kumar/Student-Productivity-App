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
                      content: const Text('Are you sure you want to reset all tasks?'),
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
            ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [

                  Text(
                    'Today\'s Schedule',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: allottedTasks.length,
                        itemBuilder: (context, index) {
                          final entry = allottedTasks[index];
                          int hour = entry.key;
                          String displayTime ;
                              
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
                            color: dailyPlannerState.isTaskCompleted[entry.key]
                                ? Colors.green[100]
                                : Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    displayTime,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: dailyPlannerState.isTaskCompleted[entry.key]
                                          ? Colors.green
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                //const Special(),
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
                          );
                        },
                      ),
                  ),
                ],
              ),
            )
            : const Center(child: Text('Start planning your day to see it here')),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageDailyy()));
            },
            icon: const Icon(Icons.edit_rounded),
            label: const Text("Manage Schedule"),
          ),
        ),
      ),
    );
  }
}