import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../models/journal_entry_dto.dart';


class JournalEntryForm extends StatefulWidget {

  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryDTO();
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleField(context),
            bodyField(context),
            ratingField(context, dropdownValue),
            const SizedBox(height: 10,),
            saveButton(context)
          ]
        ),
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
        labelText: 'Title', border: OutlineInputBorder()
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
          Navigator.of(context).pop();
        }
      },
      child: const Text('Save Entry'),
    );
  }

  void addDateToJournalEntryFields() {
    journalEntryFields.dateTime = DateTime.now();
  }

}