class EventModel {
  String name;
  DateTime date;

  EventModel({required this.name, required this.date});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      EventModel(name: json['name'], date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date.toIso8601String(),
  };
}
