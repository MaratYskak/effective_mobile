import 'package:effective_mobile/features/character/data/local/character_local_data_source.dart';
import 'package:effective_mobile/features/character/data/remote/character_remote_data_source.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<CharacterEntity>> getCharactersFromLocalDB() => localDataSource.getCharacters();

  @override
  Future<List<CharacterEntity>> getCharactersFromServer() => remoteDataSource.getCharacters();

  @override
  updateDB(List<CharacterEntity> list) => localDataSource.updateDB(list);

  @override
  Future<void> toggleFavorite(int characterId, bool isFavorite) =>
      localDataSource.toggleFavorite(characterId, isFavorite);
}
