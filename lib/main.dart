import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/database_manager.dart';
import 'screens/welcome.dart';
import 'styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  await DatabaseManager.initialize();

  runApp(MyApp(prefs: await SharedPreferences.getInstance()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  static const DARK_MODE_KEY = 'darkMode';
  
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
      },
      initialRoute: Welcome.routeName,
    );
  }

  void switchToDarkMode() {
    setState( () {
      widget.prefs.setString(DARK_MODE_KEY,
        darkMode.toString() == 'true' ? false.toString() : true.toString());
    }); 
  }


}


