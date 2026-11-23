import 'package:hive/hive.dart';

part 'favorite_show.g.dart';

@HiveType(typeId: 0)
class FavoriteShow extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String day;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime savedAt;

  FavoriteShow({
    required this.title,
    required this.day,
    required this.image,
    required this.description,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();
}