import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class GetFavoritesUsecase {
  final CharacterRepository repository;

  GetFavoritesUsecase({required this.repository});

  Future<List<CharacterEntity>> call() {
    return repository.getFavorites();
  }
}
