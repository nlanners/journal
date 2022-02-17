import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/database_manager.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  await DatabaseManager.initialize();
  bool databaseExists = await DatabaseManager.getInstance().journalIsEmpty();

  runApp(MyApp(
    prefs: await SharedPreferences.getInstance(),
    databaseExists: databaseExists));
}



