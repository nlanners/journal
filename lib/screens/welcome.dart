import 'package:flutter/material.dart';
import 'package:journal/screens/new_journal_entry.dart';

class Welcome extends StatefulWidget {
  const Welcome({
    Key? key,
    required this.switchToDarkMode,
    required this.darkMode,
    }) : super(key: key);

  static const routeName = 'Welcome';
  final void Function() switchToDarkMode;
  final String darkMode;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(Welcome.routeName)
        )
      ),
      endDrawer: settingsDrawer(),
      body: const Center(child: Text('WELCOME!!!')),
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

}