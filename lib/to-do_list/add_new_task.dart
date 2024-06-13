import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';

//const uuid = Uuid();
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
    final taskdate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);

    FirebaseFirestore.instance
        .collection(currentUser.uid)
        .doc('TODO-ITEMS')
        .set({
      'tasks': FieldValue.arrayUnion([
        {
          //'id': uuid.v4(),
          'title': _selectedTitle,
          'date': taskdate.toString().substring(0, 16),
          'priority': _selectedPriority,
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
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedDate = date;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text("Date"),
                        icon: const Icon(Icons.calendar_month_rounded),
                        hintText: (_selectedDate != null)
                            ? '${_selectedDate.year} / ${_selectedDate.month} / ${_selectedDate.day} '
                            : 'yyyy/mm/dd',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
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
                      decoration: InputDecoration(
                        label: const Text("Time"),
                        icon: const Icon(Icons.av_timer_rounded),
                        hintText: (_selectedTime != null)
                            ? '${_selectedTime.hour} : ${_selectedTime.minute}'
                            : 'hh/mm',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  )
                ],
              ),
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
