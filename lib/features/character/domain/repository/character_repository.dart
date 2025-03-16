import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharactersFromServer();
  Future<List<CharacterEntity>> getCharactersFromLocalDB();
  Future<List<CharacterEntity>> getFavorites();
  Future<void> updateDB(List<CharacterEntity> list);
  Future<void> toggleFavorite(int characterId, bool isFavorite);
}
