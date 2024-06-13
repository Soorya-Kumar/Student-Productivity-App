import 'package:flutter/material.dart';

class StatusBarTop extends StatefulWidget {
  const StatusBarTop({super.key});

  @override
  State<StatusBarTop> createState() {
    return _StatusBarTop();
  }
}

class _StatusBarTop extends State<StatusBarTop> {
  final _noofPendingTask = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(34),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(3, 10, 3, 10),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time_filled_sharp),
            const SizedBox(
              width: 10,
            ),
            Text(
              'YOU HAVE $_noofPendingTask PENDING TASKS',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
