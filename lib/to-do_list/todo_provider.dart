import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

bool overDueChecker(String today, String taskDate) {

  // today 2024-05-12
  // taskDate 2023-05-11

  for(int i=0;i<4;i++){
    if(taskDate[i] != today[i]){
      return int.parse(taskDate[i]) < int.parse(today[i]);
    }
  }

  for(int i=5;i<7;i++){
    if(taskDate[i] != today[i]){
      return int.parse(taskDate[i]) < int.parse(today[i]);
    }
  }

  for(int i=8;i<10;i++){
    if(taskDate[i] != today[i]){
      return int.parse(taskDate[i]) < int.parse(today[i]);
    }
  }
  return false;
}

final currentDateProvider = Provider<String>((ref) {
  DateTime now = DateTime.now();
  return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
});

final tasksProvider = StreamProvider.autoDispose<List>((ref) {
  return FirebaseFirestore.instance
      .collection(_currAppUser)
      .doc('TODO-ITEMS')
      .snapshots()
      .map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) return [];
        return snapshot['tasks']; // Return all tasks
      });
});

// Provider for today's tasks, depends on tasksProvider
final todayTasksProvider = Provider.autoDispose<List>((ref) {
  final today = ref.watch(currentDateProvider);
  final tasks = ref.watch(tasksProvider).asData?.value ?? [];
  return tasks.where((task) {
    return task['date'].toString().substring(0, 10) == today;
  }).toList();
});

// Provider for overdue tasks, depends on tasksProvider
final overdueTasksProvider = Provider.autoDispose<List>((ref) {
  final today = ref.watch(currentDateProvider);
  final tasks = ref.watch(tasksProvider).asData?.value ?? [];
  return tasks.where((task) {
    return overDueChecker(today, task['date']);
  }).toList();
});

final hasOverdueTasksProvider = Provider.autoDispose<bool>((ref) {
  final overdueTasks = ref.watch(overdueTasksProvider);
  return overdueTasks.isNotEmpty;
});