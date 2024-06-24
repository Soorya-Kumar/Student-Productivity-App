import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/add-subapp/attd_functions.dart';
import 'package:fusion_ease_app/add-subapp/attendance_item_widget.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

class ADDTLandingPage extends StatelessWidget {
  const ADDTLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('DASHBOARD'),
          actions: [
            IconButton(
              onPressed: () {
                addSubject(context);
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(_currAppUser)
            .doc('ATTD VALUES')
            .collection('values')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('SOMETHING WENT WRONG..'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Add a subject to get started'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) {
              var doc = snapshot.data!.docs[index];
              var subDataInfo = doc.data() as Map<String, dynamic>;
              subDataInfo['subjectName'] = doc.id; 
              return Card(
                child: PercentageIndicator(
                  subData: subDataInfo,
                  index: index,
                  context: context,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
