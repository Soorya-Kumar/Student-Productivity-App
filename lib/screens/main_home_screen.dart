import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/daily_planner/provider.dart';
import 'package:fusion_ease_app/to-do_list/today_task_page.dart';
import 'package:fusion_ease_app/widgets/bottom_navigator.dart';
import 'package:fusion_ease_app/widgets/percent_tracer.dart';

class MainHomeScreen extends ConsumerWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyPlannerState = ref.watch(dailyPlannerProvider);

    var percent = 0.0;
    if (dailyPlannerState.totalTasks == 0) {
      percent = 0;
    } else {
      percent = dailyPlannerState.completedTasks / dailyPlannerState.totalTasks;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor, 
          title: const Text(
            'Fusion Ease',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout_rounded),
              color: Colors.white,
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 111, 32, 230),
                child: const Text('TODAY\'S EVENTS AND DEADLINES',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            const TodayTasksPage(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: PercentIndicator(percentage: percent),
              ),
            ),
          ],
        ),

        bottomNavigationBar: const BootomBar(selectedpage: 0),
      ),
    );
  }
}
