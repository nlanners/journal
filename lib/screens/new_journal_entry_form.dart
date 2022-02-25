import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_manager.dart';
import '../models/journal_entry_dto.dart';
import '../screens/display_journal.dart';


class JournalEntryForm extends StatefulWidget {
  const JournalEntryForm({Key? key}) : super(key: key);

  static const routeName = 'Journal_Form';


  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryDTO();
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text('New Journal Entry'),
        centerTitle: true,
      ),
      body: form(context)
    );
  }

  Widget form(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleField(context),
              const SizedBox(height: 10,),
              bodyField(context),
              const SizedBox(height: 10,),
              ratingField(context, dropdownValue),
              const SizedBox(height: 10,),
              Row(children: [
                cancelButton(context),
                saveButton(context)],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ]
          ),
        )
      )
    );
  }

  Widget titleField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Title', border: OutlineInputBorder()
      ),
      onSaved: (value) {
        journalEntryFields.title = value.toString();
      },
      validator: (value) {
        return value!.isEmpty ? 'Please enter a title' : null;
      }
    );
  }

  Widget bodyField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Body', border: OutlineInputBorder()
      ),
      onSaved: (value) {
        journalEntryFields.body = value.toString();
      },
      validator: (value) {
        return value!.isEmpty ? 'Please enter a body' : null;
      }
    );
  }

  Widget ratingField(BuildContext context, dropdownValue) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Rating', border: OutlineInputBorder()
      ),
      value: dropdownValue,
      hint: const Text(''),
      items: const [
        DropdownMenuItem(child: Text('1'), value: 1),
        DropdownMenuItem(child: Text('2'), value: 2),
        DropdownMenuItem(child: Text('3'), value: 3),
        DropdownMenuItem(child: Text('4'), value: 4),
      ],
      onChanged: (value) {
        setState( () {dropdownValue = value;});
      },
      validator: (value) {
        return value == null ? 'Please enter a rating' : null;
      },
      onSaved: (value) {
        journalEntryFields.rating = value as int;
      }
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()){
          formKey.currentState!.save();
          addDateToJournalEntryFields();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryFields);

          debugPrint(journalEntryFields.toString());
          
          Navigator.popAndPushNamed(context, DisplayJournal.routeName);
        }
      },
      child: const Text('Save Entry'),
    );
  }

  Widget cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Cancel')
    );
  }

  void addDateToJournalEntryFields() {
    journalEntryFields.dateTime = DateFormat('EEEE, MMMM d, y').format(DateTime.now()).toString();
  }

}