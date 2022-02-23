
class JournalEntry {

  final String title;
  final String body;
  final int rating;
  final String dateTime;

  JournalEntry({
    required this.title,
    required this.body, 
    required this.rating, 
    required this.dateTime});

  JournalEntry.nullEntry() : title = 'Null', body = 'Null', rating = 0, dateTime = 'Null';

  String get entryTitle => title;
  String get entryBody => body;
  int get entryRating => rating;
  String get entryDateTime => dateTime;

}