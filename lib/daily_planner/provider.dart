import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyPlannerProvider =
    StateNotifierProvider<DailyPlannerNotifier, DailyPlannerState>((ref) {
  return DailyPlannerNotifier();
});

class DailyPlannerState {
  final List<String> dailyPlanner;
  final List<bool> isTaskCompleted;
  final int completedTasks;
  final int totalTasks;

  DailyPlannerState({
    required this.dailyPlanner,
    required this.isTaskCompleted,
    this.completedTasks = 0,
    this.totalTasks = 0,
  });

  DailyPlannerState copyWith({
    List<String>? dailyPlanner,
    List<bool>? isTaskCompleted,
    int? completedTasks,
    int? totalTasks,
  }) {
    return DailyPlannerState(
      dailyPlanner: dailyPlanner ?? this.dailyPlanner,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
      completedTasks: completedTasks ?? this.completedTasks,
      totalTasks: totalTasks ?? this.totalTasks,
    );
  }
}

class DailyPlannerNotifier extends StateNotifier<DailyPlannerState> {
  DailyPlannerNotifier()
      : super(DailyPlannerState(
            dailyPlanner: List.filled(24, ''),
            isTaskCompleted: List.filled(24, false)));

  void addTask(int hour, String task) {
    if (hour >= 0 && hour <= 23) {
      state = state.copyWith(
        dailyPlanner: List.from(state.dailyPlanner)..[hour] = task,
        totalTasks: state.totalTasks + 1,
      );
    }
  }

  void toggleTaskCompletion(int index, bool isCompleted) {
    var updatedIsTaskCompleted = List<bool>.from(state.isTaskCompleted);
    updatedIsTaskCompleted[index] = isCompleted;
    if (state.dailyPlanner[index] != '') {
      state = state.copyWith(
        isTaskCompleted: updatedIsTaskCompleted,
        completedTasks:
            isCompleted ? state.completedTasks + 1 : state.completedTasks - 1,
      );
    }
  }

  void addParticularTask(BuildContext context, int index) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: "Task"),
          ),
          actions: <Widget>[
            FilledButton(
              child: const Text('Submit'),
              onPressed: () {
                String taskInput = taskController.text;
                if (taskInput.isNotEmpty) {
                  state = state.copyWith(
                    dailyPlanner: List.from(state.dailyPlanner)
                      ..[index] = taskInput,
                    totalTasks: state.totalTasks + 1,
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearParticularTask(int index) {
    state = state.copyWith(
      dailyPlanner: List.from(state.dailyPlanner)..[index] = '',
      isTaskCompleted: List.from(state.isTaskCompleted)..[index] = false,
      totalTasks: state.totalTasks - 1,
      completedTasks: state.isTaskCompleted[index]
          ? state.completedTasks - 1
          : state.completedTasks,
    );
  }

  void resetTasks() {
    state = DailyPlannerState(
      dailyPlanner: List.filled(24, ''),
      isTaskCompleted: List.filled(24, false),
      completedTasks: 0,
      totalTasks: 0,
    );
  }
}