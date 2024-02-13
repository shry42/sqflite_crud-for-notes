import 'package:flutter/material.dart';
import 'package:sqflite_crud/models/notes.dart';
import 'package:sqflite_crud/repository/notes_repository.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
        actions: [
          IconButton(
            onPressed: _insertNotes,
            icon: const Icon(Icons.done),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: 'Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: 'Start Typing here...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insertNotes() async {
    final note = Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await NotesRepository.insert(note: note);
  }
}
