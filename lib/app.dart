import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/database_manager.dart';
import 'screens/display_journal.dart';
import 'screens/new_journal_entry.dart';
import 'screens/welcome.dart';
import 'styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.prefs, required this.databaseExists}) : super(key: key);

  final SharedPreferences prefs;
  final bool databaseExists;

  @override
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  static const DARK_MODE_KEY = 'darkMode';
  DatabaseManager databaseManager = DatabaseManager.getInstance();
  
  String get darkMode =>
    widget.prefs.getString(DARK_MODE_KEY) ?? 'false';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: Styles.lightTheme,
      darkTheme: Styles.darkTheme,
      themeMode: 
        widget.prefs.getString(DARK_MODE_KEY) == 'true' ? 
          ThemeMode.dark : ThemeMode.light,
      routes: {
        Welcome.routeName: (context) => Welcome(
          switchToDarkMode: switchToDarkMode,
          darkMode: darkMode),

        JournalEntryForm.routeName: (context) => const JournalEntryForm(),

        DispalyJournal.routeName: (context) => DispalyJournal(
          switchToDarkMode: switchToDarkMode,
          darkMode: darkMode
        )
      },
      initialRoute: widget.databaseExists ? DispalyJournal.routeName : Welcome.routeName
    );
  }

  void switchToDarkMode() {
    setState( () {
      widget.prefs.setString(DARK_MODE_KEY,
        darkMode.toString() == 'true' ? false.toString() : true.toString());
    }); 
  }

    

}
