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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DisplayJournal.routeName),
        centerTitle: true,
      ),
      endDrawer: settingsDrawer(),
      body: LayoutBuilder(builder: layoutDecider),
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

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) =>
    constraints.maxWidth < 600 ? VerticalLayout(db: widget.db) : HorizontalLayout(db: widget.db);
}

class HorizontalLayout extends StatefulWidget {
  const HorizontalLayout({ Key? key, required this.db}) : super(key: key);

  final DatabaseManager db;
  

  @override
  _HorizontalLayoutState createState() => _HorizontalLayoutState();
}

class _HorizontalLayoutState extends State<HorizontalLayout> {

  Widget right = firstRight();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: JournalList(db: widget.db, horizontal: true, updateRight: updateRight,)),
        Expanded(child: right)
      ],
    );
  }

  static Widget firstRight() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Choose a Journal Entry'),
        Icon(Icons.keyboard_backspace)
      ],
    );
  }

  void updateRight(JournalEntry entry) {
    setState( () {
      right = JournalBody.journalBodyDisplay(entry);
    });
  }

}

class VerticalLayout extends StatelessWidget {
  const VerticalLayout({ Key? key, required this.db }) : super(key: key);

  final DatabaseManager db;

  @override
  Widget build(BuildContext context) {
    return JournalList(db: db, horizontal: false,);
  }
}


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
      body: journalBodyDisplay(entry)
    );
  }

  static Widget journalBodyDisplay(entry) {
    return Column(
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
    );
  }
}