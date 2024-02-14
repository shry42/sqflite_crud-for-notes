import 'package:flutter/material.dart';
import 'package:sqflite_crud/models/notes.dart';
import 'package:sqflite_crud/repository/notes_repository.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();

  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title.toString();
      _description.text = widget.note!.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text(
                                  'Are you sure you want to delete this note?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteNote();
                                    },
                                    child: const Text('Yes')),
                              ],
                            ));
                  },
                  icon: const Icon(Icons.delete_outline))
              : const SizedBox(),
          IconButton(
            onPressed: widget.note == null ? _insertNotes : _updateNote,
            icon: const Icon(Icons.done),
          ),
          const SizedBox(width: 10),
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

  _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
    );
    await NotesRepository.update(note: note);
  }

  _deleteNote() async {
    NotesRepository.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
  }
}
