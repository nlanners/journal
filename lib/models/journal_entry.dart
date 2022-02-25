
class JournalEntry {

  final String title;
  final String body;
  final int rating;
  final String dateTime;
  final int id;

  JournalEntry({
    required this.title,
    required this.body, 
    required this.rating, 
    required this.dateTime,
    required this.id});

  JournalEntry.nullEntry() : title = 'Null', body = 'Null', rating = 0, dateTime = 'Null', id = 0;

  String get entryTitle => title;
  String get entryBody => body;
  int get entryRating => rating;
  String get entryDateTime => dateTime;
  int get entryID => id;

}