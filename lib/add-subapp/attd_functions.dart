import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _currAppUser = FirebaseAuth.instance.currentUser!.uid;

dynamic addSubject(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      String subjectName = '';
      int totalClass = 0;
      int attendedClass = 0;
      final formKey = GlobalKey<FormState>();

      return Container(
        color: const Color.fromARGB(255, 252, 237, 255),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  subjectName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject name';
                  }
                  return null;                
                },
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                onChanged: (value) {
                  totalClass = int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter total classes';
                  }
                  return null;             
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Classes',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                onChanged: (value) {
                  attendedClass = int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter attended classes';
                  }
                  if(int.tryParse(value)! > totalClass){
                    return 'Attended classes cannot be greater than total classes';
                  }
                  return null;             
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Attended Classes',
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection(_currAppUser)
                        .doc('ATTD VALUES')
                        .collection('values')
                        .doc(subjectName)
                        .set({
                      'subject': subjectName,
                      'total': totalClass,
                      'attended': attendedClass,
                    });

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

dynamic deleteItem(BuildContext context, int tot, int att, String subjectName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete $subjectName"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection(_currAppUser)
                  .doc('ATTD VALUES')
                  .collection('values')
                  .doc(subjectName)
                  .delete()
                  .then((_) {
                Navigator.of(context).pop();
              }).catchError((error) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Error"),
                      content: Text(
                          "Failed to delete $subjectName. Please try again."),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            },
          ),
        ],
      );
    },
  );
}

void presentButtonFunction(String subjectName) {
  FirebaseFirestore.instance
      .collection(_currAppUser)
      .doc('ATTD VALUES')
      .collection('values')
      .doc(subjectName)
      .update({
    'total': FieldValue.increment(1),
    'attended': FieldValue.increment(1),
  });
}

void absentButtonFunction(String subjectName) {
  FirebaseFirestore.instance
      .collection(_currAppUser)
      .doc('ATTD VALUES')
      .collection('values')
      .doc(subjectName)
      .update({
    'total': FieldValue.increment(1),
  });
}
