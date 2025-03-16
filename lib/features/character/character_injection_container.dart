import 'package:effective_mobile/features/character/data/local/character_local_data_source.dart';
import 'package:effective_mobile/features/character/data/local/character_local_data_source_impl.dart';
import 'package:effective_mobile/features/character/data/remote/character_remote_data_source.dart';
import 'package:effective_mobile/features/character/data/remote/character_remote_data_source_impl.dart';
import 'package:effective_mobile/features/character/data/repository/character_repository_impl.dart';
import 'package:effective_mobile/features/character/domain/repository/character_repository.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_local_db_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_server_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/toggle_favorite_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/update_db_usecase.dart';
import 'package:effective_mobile/features/character/presentation/cubits/characters/character_cubit.dart';
import 'package:effective_mobile/main_injection_container.dart';

Future<void> characterInjectionContainer() async {
  // * CUBITS INJECTION

  sl.registerFactory<CharacterCubit>(() => CharacterCubit(
        getCharactersFromLocalDbUsecase: sl.call(),
        getCharactersFromServerUsecase: sl.call(),
        updateDbUsecase: sl.call(),
        toggleFavoriteUsecase: sl.call(),
      ));

  // * USE CASES INJECTION

  sl.registerLazySingleton<GetCharactersFromLocalDbUsecase>(
      () => GetCharactersFromLocalDbUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCharactersFromServerUsecase>(() => GetCharactersFromServerUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateDbUsecase>(() => UpdateDbUsecase(repository: sl.call()));
  sl.registerLazySingleton<ToggleFavoriteUsecase>(() => ToggleFavoriteUsecase(sl.call()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(remoteDataSource: sl.call(), localDataSource: sl.call()));

  sl.registerLazySingleton<CharacterRemoteDataSource>(() => CharacterRemoteDataSourceImpl());
  sl.registerLazySingleton<CharacterLocalDataSource>(() => CharacterLocalDataSourceImpl(db: sl.call()));
}
