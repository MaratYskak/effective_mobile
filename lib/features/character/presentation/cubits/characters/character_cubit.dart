import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:effective_mobile/features/character/data/models/character_model.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_local_db_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_server_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/toggle_favorite_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/update_db_usecase.dart';
import 'package:equatable/equatable.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharactersFromLocalDbUsecase getCharactersFromLocalDbUsecase;
  final GetCharactersFromServerUsecase getCharactersFromServerUsecase;
  final UpdateDbUsecase updateDbUsecase;
  final ToggleFavoriteUsecase toggleFavoriteUsecase;

  CharacterCubit({
    required this.getCharactersFromLocalDbUsecase,
    required this.getCharactersFromServerUsecase,
    required this.updateDbUsecase,
    required this.toggleFavoriteUsecase,
  }) : super(CharacterInitial());

  Future<void> fetchCharacters() async {
    emit(CharacterLoading());
    try {
      final localCharacters = await getCharactersFromLocalDbUsecase.call();
      if (localCharacters.isNotEmpty) {
        emit(CharacterLoaded(localCharacters));
      } else {
        final remoteCharacters = await getCharactersFromServerUsecase.call();
        await updateDbUsecase.call(remoteCharacters);
      }
    } on SocketException {
      emit(CharacterError('No Internet connection'));
    } catch (e) {
      emit(CharacterError('Failed to load characters: $e'));
    }
  }

  Future<void> updateDB() async {
    try {
      final remoteCharacters = await getCharactersFromServerUsecase.call();
      await updateDbUsecase.call(remoteCharacters);
      final localCharacters = await getCharactersFromLocalDbUsecase.call();
      emit(CharacterLoaded(localCharacters));
    } on SocketException {
      emit(CharacterError('No Internet connection'));
    } catch (e) {
      emit(CharacterError('Failed to update database: $e'));
    }
  }

  Future<void> toggleFavorite({required int characterId, required bool isFavorite}) async {
    await toggleFavoriteUsecase.call(characterId, isFavorite);

    // Обновляем список персонажей в состоянии
    final updatedCharacters = (state as CharacterLoaded).characters.map((character) {
      if (character.id == characterId) {
        final characterModel = CharacterModel.fromEntity(character);
        return characterModel.copyWith(favorite: isFavorite);
      }
      final characterModel = CharacterModel.fromEntity(character);
      return characterModel;
    }).toList();

    emit(CharacterLoaded(updatedCharacters));
  }
}
