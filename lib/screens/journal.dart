import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  const Journal({ Key? key,
    required this.switchToDarkMode,
    required this.darkMode,
    }) : super(key: key);

  static const routeName = 'Journal';
  final void Function() switchToDarkMode;
  final String darkMode;

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      endDrawer: settingsDrawer(),
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
}