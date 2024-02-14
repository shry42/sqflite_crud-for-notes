import 'package:flutter/material.dart';
import 'package:sqflite_crud/repository/notes_repository.dart';
import 'package:sqflite_crud/screens/add_note/add_note_screen.dart';
import 'package:sqflite_crud/screens/home/widgets/items.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
          future: NotesRepository.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text('Empty'));
              }
              return ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  for (var note in snapshot.data!)
                    ItemNote(
                      note: note,
                    ),
                ],
              );
            }
            return const SizedBox();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNoteScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
