import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class GetCharactersUsecase {
  final CharacterRepository repository;

  GetCharactersUsecase({required this.repository});

  Stream<List<CharacterEntity>> call() {
    return repository.getCharacters();
  }
}
