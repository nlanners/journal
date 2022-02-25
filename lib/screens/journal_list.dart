import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../models/journal_entry.dart';
import 'journal_body.dart';

class JournalList extends StatefulWidget {
  const JournalList({
    Key? key,
    required this.db,
    required this.horizontal,
    this.updateRight
    }) : super(key: key);

  final DatabaseManager db;
  final bool horizontal;
  final void Function(JournalEntry)? updateRight;

  @override
  State<JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {

  ListView? entryTiles;

  @override
  Widget build(BuildContext context) {
    return Container(child: journalBody());
  }

   Widget? journalBody() {
    if (entryTiles == null) {
      entriesList();
      return const CircularProgressIndicator();
    } else {
      return entryTiles;
    }
  }

  void entriesList() async {
    var entries = await widget.db.journalEntries();
    setState( () {
      entryTiles = ListView(
        padding: const EdgeInsets.all(10),
        children: entriesListTiles(journalEntryList(entries))
      );
    }); 
  }

  List<JournalEntry> journalEntryList(data) {
    List<JournalEntry> entries = List.filled(
      data.length, JournalEntry.nullEntry()
    );

    data.forEach( (entry) {
      JournalEntry je = JournalEntry(
        title: entry['title'],
        body: entry['body'],
        rating: entry['rating'],
        dateTime: entry['date'],
        id: entry['id']
      );

      entries[entry['id'] - 1] = je;
    });

    return entries;
  }

  List<ListTile> entriesListTiles(entries) {
    List<ListTile> listTiles = [];

    for( var entry in entries) {
      var tile = ListTile(
        title: Text(entry.entryTitle),
        subtitle: Text(entry.entryDateTime),
        onTap: () {
          if (widget.horizontal) {
            widget.updateRight!(entry);
          } else {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JournalBody(entry: entry))
            );
          }
        }
      );

      listTiles.add(tile);
    }

    return listTiles;
  }
}