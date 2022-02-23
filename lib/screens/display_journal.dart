import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../models/journal_entry.dart';

class DispalyJournal extends StatefulWidget {
  DispalyJournal({ Key? key,
    required this.switchToDarkMode,
    required this.darkMode,
    }) : super(key: key);

  static const routeName = 'Journal';
  final DatabaseManager db = DatabaseManager.getInstance();
  final void Function() switchToDarkMode;
  final String darkMode;
  

  @override
  _DispalyJournalState createState() => _DispalyJournalState();
}

class _DispalyJournalState extends State<DispalyJournal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      endDrawer: settingsDrawer(),
      body: entriesList(),
    );
  }

  Widget settingsDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            title: Text('Settings'),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: widget.darkMode == 'true' ? true : false,
            onChanged: (bool value) {
              setState( () {
                widget.switchToDarkMode();
              });
            },
          ),
          const Divider(),
          ElevatedButton(
            child: const Text('Save Settings'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }

  Widget entriesList() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: entriesListTiles(entryMap(widget.db.journalEntries()))
    );
  }

  List<JournalEntry> entryMap(data) {
    List<JournalEntry> entries = List.filled(
      data.length, JournalEntry.nullEntry()
    );

    data.forEach( (entry) {
      JournalEntry je = JournalEntry(
        title: entry['title'],
        body: entry['body'],
        rating: entry['rating'],
        dateTime: entry['dateTime']
      );

      entries[entry['id']] = je;
    });

    return entries;
  }

  List<ListTile> entriesListTiles(List<JournalEntry> entries) {
    List<ListTile> listTiles = [];

    for( var entry in entries) {
      var tile = ListTile(
        title: Text(entry.entryTitle),
        subtitle: Text(entry.entryDateTime),
        onTap: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JournalBody(entry: entry))
          );
        },
      );

      listTiles.add(tile);
    }

    return listTiles;
  }

}

class JournalBody extends StatelessWidget {
  const JournalBody({Key? key, required this.entry}) : super(key: key);

  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.entryDateTime)
      ),
      body: Column(
        children: [
          Text(entry.entryTitle),
          Text(entry.entryBody),
          Text('Rating: ' + entry.entryRating.toString())
        ],
      )
    );
  }
  }