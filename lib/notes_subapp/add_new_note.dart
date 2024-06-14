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

  final _selectedDate = DateTime.now();
  final _selectedTime = TimeOfDay.now();

  String? _selectedTitle;
  dynamic _selectedDateTime;
  String? _selectedMsg;
  int _colorIndex = 0;

  
  final lightColors = [
    Colors.amber.shade300,
    Colors.white,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController msgController = TextEditingController();
  
  @override
  void initState() {
    _selectedDateTime = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    super.initState();
  }

  void addNote() {
    //print(_selectedTitle);
    //print(_selectedDateTime);
    //print(_selectedMsg);

    _selectedTitle = titleController.text;
    _selectedMsg = msgController.text;

    if (_selectedTitle == null || _selectedTitle!.isEmpty || _selectedMsg == null) 
    {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all details'),
        ),
      );
      return;
    }

    FirebaseFirestore.instance
        .collection(currentUser.uid)
        .doc('NOTES')
        .set({
      'notes': FieldValue.arrayUnion([
        {
          //'id': uuid.v4(),
          'title': _selectedTitle,
          'date': _selectedDateTime.toString().substring(0, 16),
          'msg': _selectedMsg,
          'color': _colorIndex,
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
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 121, 51, 243),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: addNote,
            ),],
          title: const Text('Add New Note'),
        ),
        
        body: Container(
          color: lightColors[_colorIndex],
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      
                      Expanded(
                        flex: 8, 
                        child: TextFormField(
                          maxLines: null,
                          autofocus: true,
                          controller: titleController,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Title",
                          ),
                          style: const TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      const SizedBox(
                        width: 1,
                      ),
                      
                      Flexible(
                        flex: 2, 
                        child: DropdownButtonFormField<int>(
                          value: _colorIndex,
                          dropdownColor: Colors.grey,
                          decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(), 
                          ),
                          items: [
                            for (final color in lightColors)
                              DropdownMenuItem(
                                value: lightColors.indexOf(color),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  color: color,
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _colorIndex = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
            
                  Text(
                    'Created on   ${_selectedDateTime.toString().substring(0, 11)}  ${_selectedDateTime.toString().substring(11, 16)}',
                  ),
            
                  const SizedBox(
                    height: 12,
                  ),
        
                  const Divider(
                    color:  Color.fromARGB(255, 0, 0, 0),
                    thickness: 2,
                  ),
        
                  const SizedBox(
                    height: 30,
                  ),
        
                  TextFormField(
                    maxLines: null,
                    autocorrect: true,
                    enableSuggestions: true,
                    controller: msgController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration.collapsed(
                      fillColor: lightColors[_colorIndex],
                      filled: true,
                      hintText: "Click here and start typing... \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
