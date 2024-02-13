import 'package:flutter/material.dart';
import 'package:sqflite_crud/models/notes.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({super.key, required this.note});

  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
            child: Column(
              children: [
                const Text(
                  'DEC',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 2),
                Text('02',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 2),
                const Text(
                  '2024',
                  style: TextStyle(color: Colors.white70),
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
                    note!.createdAt.toString(),
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
    );
  }
}
