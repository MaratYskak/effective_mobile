import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class UpdateDbUsecase {
  final CharacterRepository repository;

  UpdateDbUsecase({required this.repository});

  Future<void> call(List<CharacterEntity> characters) async {
    return await repository.updateDB(characters);
  }
}
