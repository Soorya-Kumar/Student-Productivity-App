import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

void deleteTask(taskData, int index, BuildContext context){
    FirebaseFirestore.instance
        .collection(_currAppUser)
        .doc('TODO-ITEMS')
        .update({
      'tasks': FieldValue.arrayRemove([taskData])
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: const Text('Task successfully completed'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
        FirebaseFirestore.instance
          .collection(_currAppUser)
          .doc('TODO-ITEMS')
          .update({'tasks': FieldValue.arrayUnion([taskData])});
        },
      ),
      ),
    );     
}


Color? colorGiver(String priority){
    if(priority == 'high')
    {
      return Colors.red[100];
    }
    else if(priority == 'medium')
    {
      return Colors.yellow[100];
    }
    else
    {
      return Colors.green[100];
    }
  }