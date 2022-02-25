import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../styles.dart';

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