
class JournalEntryDTO {

  late String title;
  late String body;
  late int rating;
  late DateTime dateTime;

  String toString() =>
    'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
}