
class JournalEntryDTO {

  String? title;
  String? body;
  int? rating;
  String? dateTime;

  @override
  String toString() =>
    'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
}