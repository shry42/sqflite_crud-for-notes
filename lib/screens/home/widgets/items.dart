import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_crud/models/notes.dart';
import 'package:sqflite_crud/screens/add_note/add_note_screen.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({super.key, required this.note});
  final Note? note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteScreen(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: Column(
                children: [
                  Text(
                    DateFormat(DateFormat.ABBR_MONTH).format(note!.createdAt),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 2),
                  Text(DateFormat(DateFormat.DAY).format(note!.createdAt),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 2),
                  Text(
                    note!.createdAt.year.toString(),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        note!.title.toString(),
                        // 'ok',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      // '12:30 PM',
                      DateFormat(DateFormat.HOUR_MINUTE)
                          .format(note!.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Text(
                  note!.description.toString(),
                  // 'ok desc',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
