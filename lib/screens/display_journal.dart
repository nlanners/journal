import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../models/journal_entry.dart';
import '../screens/new_journal_entry_form.dart';
import 'journal_body.dart';
import 'journal_list.dart';

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




