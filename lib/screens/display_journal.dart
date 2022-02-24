import 'package:flutter/material.dart';
import '../styles.dart';
import '../db/database_manager.dart';
import '../models/journal_entry.dart';
import '../screens/new_journal_entry_form.dart';

class DisplayJournal extends StatefulWidget {
  DisplayJournal({ Key? key,
    required this.switchToDarkMode,
    required this.darkMode,
    }) : super(key: key);

  static const routeName = 'Journal';
  final DatabaseManager db = DatabaseManager.getInstance();
  final void Function() switchToDarkMode;
  final String darkMode;
  

  @override
  _DisplayJournalState createState() => _DisplayJournalState();
}

class _DisplayJournalState extends State<DisplayJournal> {

  ListView? entryTiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DisplayJournal.routeName),
        centerTitle: true,
      ),
      endDrawer: settingsDrawer(),
      body: journalBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, JournalEntryForm.routeName);
        },
        child: const Icon(Icons.add)),
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
        dateTime: entry['date']
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
        title: Text(entry.entryDateTime),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(entry.entryTitle, style: Styles.titleText),
            ),
          ),
          Align(alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text('Rating: ' + entry.entryRating.toString(), style: Styles.subtitleText),
            )
          ),
          Align(alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(entry.entryBody, style: Styles.normalText),
            )
          ),
          
        ],
      )
    );
  }
  }