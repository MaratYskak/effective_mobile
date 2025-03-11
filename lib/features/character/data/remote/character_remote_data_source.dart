import 'package:effective_mobile/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Stream<List<CharacterModel>> getCharacters();
}
