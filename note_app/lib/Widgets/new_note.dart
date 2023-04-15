import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewNote extends StatefulWidget {

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  // void _submitData() {
  //   if (_descriptionController.text.isEmpty) {
  //     return;
  //   }

  //   final enteredTitle = _titleController.text;
  //   final enteredDescription = _descriptionController.text;

  //   if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
  //     return;
  //   }

  //   ref.add({
  //       'title': _titleController,
  //       'description': _descriptionController
  //   }).whenComplete(() => Navigator.of(context).pop());

  //   // widget.addNote(enteredTitle, enteredDescription);
  //   // Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
                controller: _titleController,
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'description',
                ),
                minLines: 1,
                maxLines: 10,
                controller: _descriptionController,
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                ),
                child: const Text('Add Note',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {
                    ref.add({
                        'title': _titleController.text,
                        'description': _descriptionController.text  
                    }).whenComplete(() => Navigator.of(context).pop());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
