import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class GetCharactersFromLocalDbUsecase {
  final CharacterRepository repository;

  GetCharactersFromLocalDbUsecase({required this.repository});

  Future<List<CharacterEntity>> call() {
    return repository.getCharactersFromLocalDB();
  }
}
