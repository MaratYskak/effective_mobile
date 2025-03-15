import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class GetCharactersFromServerUsecase {
  final CharacterRepository repository;

  GetCharactersFromServerUsecase({required this.repository});

  Future<List<CharacterEntity>> call() {
    return repository.getCharactersFromServer();
  }
}
