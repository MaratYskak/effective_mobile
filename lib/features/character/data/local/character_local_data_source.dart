import 'package:effective_mobile/features/character/data/models/character_model.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<List<CharacterEntity>> getFavorites();
  Future<void> updateDB(List<CharacterEntity> characters);
  Future<void> toggleFavorite(int characterId, bool isFavorite);
}
