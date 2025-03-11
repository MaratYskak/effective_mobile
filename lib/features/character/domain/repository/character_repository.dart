import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Stream<List<CharacterEntity>> getCharacters();
}
