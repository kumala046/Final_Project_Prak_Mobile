import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/favorite_show.dart';

class FavoriteService {
  static const String _boxName = 'favorites';

  static Box<FavoriteShow> get _box => Hive.box<FavoriteShow>(_boxName);

  static Future<bool> toggle(FavoriteShow show) async {
    final existing = _box.values.where((s) => s.title == show.title).toList();
    if (existing.isNotEmpty) {
      await existing.first.delete();
      return false;
    }
    await _box.add(show);
    return true;
  }

  static bool isFavorite(String title) {
    return _box.values.any((s) => s.title == title);
  }

  static List<FavoriteShow> getAll() {
    final list = _box.values.toList();
    list.sort((a, b) => b.savedAt.compareTo(a.savedAt));
    return list;
  }

  static Future<void> remove(FavoriteShow show) async => await show.delete();

  static ValueListenable<Box<FavoriteShow>> listenable() => _box.listenable();
}