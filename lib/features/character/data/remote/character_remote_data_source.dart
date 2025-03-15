import 'package:effective_mobile/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
}
