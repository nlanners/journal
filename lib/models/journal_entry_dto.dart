
class JournalEntryDTO {

  String? title;
  String? body;
  int? rating;
  DateTime? dateTime;

  @override
  String toString() =>
    'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
}