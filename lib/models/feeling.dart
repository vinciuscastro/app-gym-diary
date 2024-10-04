class Feeling {
  final String id, feeling, date;

  Feeling({
    required this.id,
    required this.feeling,
    required this.date,
  });

  Feeling.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        feeling = json['feeling'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'feeling': feeling,
    'date': date,
  };

}