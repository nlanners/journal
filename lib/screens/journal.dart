import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  const Journal({ Key? key }) : super(key: key);
  static const routeName = 'Journal';

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
      endDrawer: ,
    );
  }
}