import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool done;

  @HiveField(2)
  DateTime created;

  Task({
    required this.title,
    this.done = false,
    DateTime? created,
  }) : created = created ?? DateTime.now();
}