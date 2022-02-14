import 'package:flutter/material.dart';

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
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Settings'),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: widget.darkMode == 'true' ? true : false,
              onChanged: (bool value) {
                setState( () {
                  widget.switchToDarkMode();
                });
              },
              
            ),
          ],)
      ),
    );
  }


}