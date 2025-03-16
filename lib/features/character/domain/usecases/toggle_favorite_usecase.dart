import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class ToggleFavoriteUsecase {
  final CharacterRepository repository;

  ToggleFavoriteUsecase(this.repository);

  Future<void> call(int characterId, bool isFavorite) async {
    return await repository.toggleFavorite(characterId, isFavorite);
  }
}
