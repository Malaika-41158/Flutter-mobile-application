class Task {
  String title;
  bool isDone;
  DateTime createdAt;

  Task({
    required this.title,
    this.isDone = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Task → Map
  Map<String, dynamic> toJson() => {
    "title": title,
    "isDone": isDone,
    "createdAt": createdAt.toIso8601String(),
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"],
    isDone: json["isDone"],
    createdAt: DateTime.parse(json["createdAt"]),
  );
}