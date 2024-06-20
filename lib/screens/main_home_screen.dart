import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusion_ease_app/daily_planner/provider.dart';
import 'package:fusion_ease_app/screens/user_profile.dart';
import 'package:fusion_ease_app/to-do_list/today_task_page.dart';
import 'package:fusion_ease_app/widgets/bottom_navigator.dart';
import 'package:fusion_ease_app/widgets/percent_tracer.dart';


final user = FirebaseAuth.instance.currentUser!.uid;
final userinfo = FirebaseFirestore.instance.collection('users').doc(user).get();

final userimageurl = userinfo.then((value) => value['profilePhoto']);


class MainHomeScreen extends ConsumerWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyPlannerState = ref.watch(dailyPlannerProvider);
    print(userimageurl);

    double percent;
    if(dailyPlannerState.totalTasks == 0){
      percent = 0.0;
    } else {
      percent = dailyPlannerState.completedTasks / dailyPlannerState.totalTasks;
    }
    
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            UserProfileWidget(),
            Expanded(
              child: CustomScrollView(
                  slivers: <Widget>[
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
              
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          'WELCOME\nBACK !!',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
              
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'TODAY\'S EVENTS AND DEADLINES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                   
                   const TodayTasksPage(),
                   
                    const SliverToBoxAdapter(child: SizedBox(height: 150)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 120,
                        child: PercentIndicator(percentage: percent),
                      ),
                    ),
                    
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'You have completed ${dailyPlannerState.completedTasks} out of ${dailyPlannerState.totalTasks} tasks',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
            
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
            
                  ],
                ),
            ),
          ],
        ),
        
        
        
        bottomNavigationBar: const BootomBar(selectedpage: 0),
      ),
    );
  }
}
