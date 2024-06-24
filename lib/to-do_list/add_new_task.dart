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

  dynamic _selectedDate;
  dynamic _selectedTime;
  String? _selectedPriority;
  String?  _selectedTitle;

  void addTask() {

    if (_selectedTitle == null || _selectedTitle!.isEmpty ||
        _selectedPriority == null ||
        _selectedDate == null ||
        _selectedTime == null) 
    {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all details'),
        ),
      );
      return;
    }

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
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      maxLength: 50,
                      autocorrect: false,
                      onChanged: (newValue) {
                        _selectedTitle = newValue;
                      },
                      cursorColor: const Color.fromARGB(255, 29, 125, 241),
                      cursorWidth: 1.3,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter task title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.title),
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
              
              
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Priority',
                  prefixIcon: const Icon(Icons.priority_high),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                value: _selectedPriority,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriority = newValue;
                  });
                },
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
              ),
              
              const SizedBox(
                height: 30,
              ),
             
             TextFormField(
              readOnly: true,
              controller: TextEditingController(text: (_selectedDate != null)
                            ? '${_selectedDate.year} / ${_selectedDate.month} / ${_selectedDate.day}'
                            : 'yyyy/mm//dd',),
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
                labelText: 'Date',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.calendar_today),
              ),
            ),
             
             const SizedBox(
                height: 30,
              ),

              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                    text: _selectedTime != null
                        ? _selectedTime.format(context)
                        : ''),
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
                  labelText: 'Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.access_time),
                ),
            ),
              
              const SizedBox(
                height: 30,
              ),
              
              ElevatedButton(
                onPressed: addTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Add Task'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
