import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TaskModel {
  TaskModel(
      {required this.title,
      required this.date,
      required this.priority,
      required this.status,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final String priority;
  bool status;
}
