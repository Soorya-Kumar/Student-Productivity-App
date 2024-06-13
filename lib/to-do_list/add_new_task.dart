import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_ease_app/to-do_list/dummydata.dart';
import 'package:fusion_ease_app/to-do_list/task_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!;

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() {
    return _AddNewItem();
  }
}

class _AddNewItem extends State<AddNewItem> {
  var _selectedDate;
  var _selectedTime;
  var _selectedPriority;
  var _selectedTitle = '';

  void addTask() {
    final _Taskdate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    final newTask = TaskModel(
        title: _selectedTitle,
        date: _Taskdate,
        priority: _selectedPriority,
        status: false);
    todolistitems.add(newTask);

    FirebaseFirestore.instance.collection(currentUser.uid).doc('TODO-ITEMS').set({
      'tasks': FieldValue.arrayUnion([
        {
          'title': _selectedTitle,
          'date': _Taskdate.toString().substring(0, 16),
          'priority': _selectedPriority,
          'status': false
        }
      ])
    }, SetOptions(merge: true));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Add New Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      autocorrect: false,
                      onChanged: (newValue) {
                        _selectedTitle = newValue;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: _selectedPriority,
                alignment: Alignment.centerLeft,
                hint: const Text('Select Priority'),
                items: const [
                  DropdownMenuItem(
                    value: 'low',
                    child: Text('Low'),
                  ),
                  DropdownMenuItem(
                    value: 'medium',
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: 'high',
                    child: Text('High'),
                  ),
                ],
                onChanged: (value) {
                  _selectedPriority = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                      hintText: (_selectedDate != null)
                          ? 'Date:      ${_selectedDate.year} / ${_selectedDate.month} / ${_selectedDate.day} '
                          : 'yyyy/mm//dd',
                    )),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
              FilledButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Choose Date')),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                      hintText: (_selectedTime != null)
                          ? 'Time:      ${_selectedTime.hour} : ${_selectedTime.minute} '
                          : 'hh/mm',
                    )),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
              FilledButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime;
                      });
                    }
                  },
                  child: const Text('Choose Time')),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                  onPressed: () {
                    addTask();
                  },
                  child: const Text('Add Task')),
            ],
          ),
        ),
      ),
    );
  }
}
