import 'package:effective_mobile/features/character/data/local/character_local_data_source.dart';
import 'package:effective_mobile/features/character/data/models/character_model.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:sqflite/sqflite.dart';

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Database db;

  CharacterLocalDataSourceImpl({required this.db});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final List<Map<String, dynamic>> maps = await db.query('characters');
    return List.generate(maps.length, (i) {
      return CharacterModel.fromJson(maps[i]);
    });
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    final List<Map<String, dynamic>> maps = await db.query(
      'characters',
      where: 'favorite = ?',
      whereArgs: [1], // 1 означает true
    );

    return maps.map((map) => CharacterModel.fromJson(map)).toList();
  }

  @override
  Future<void> updateDB(List<CharacterEntity> characters) async {
    final batch = db.batch();

    for (var character in characters) {
      final characterModel = CharacterModel.fromEntity(character);
      // Проверяем, есть ли персонаж в базе
      final existing = await db.query(
        'characters',
        where: 'id = ?',
        whereArgs: [characterModel.id],
      );

      if (existing.isNotEmpty) {
        // Если запись уже есть, сохраняем старое значение favorite
        final bool existingFavorite = existing.first['favorite'] == 1;

        final updatedCharacter = characterModel.copyWith(favorite: existingFavorite);

        batch.update(
          'characters',
          updatedCharacter.toJson(),
          where: 'id = ?',
          whereArgs: [updatedCharacter.id],
        );
      } else {
        // Если записи нет, просто вставляем нового персонажа
        batch.insert(
          'characters',
          characterModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> toggleFavorite(int characterId, bool isFavorite) async {
    final batch = db.batch();
    batch.update(
      'characters',
      {'favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [characterId],
    );
    await batch.commit(noResult: true);
  }
}
