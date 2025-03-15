import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_local_db_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_characters_from_server_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/update_db_usecase.dart';
import 'package:equatable/equatable.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharactersFromLocalDbUsecase getCharactersFromLocalDbUsecase;
  final GetCharactersFromServerUsecase getCharactersFromServerUsecase;
  final UpdateDbUsecase updateDbUsecase;

  CharacterCubit(
      {required this.getCharactersFromLocalDbUsecase,
      required this.getCharactersFromServerUsecase,
      required this.updateDbUsecase})
      : super(CharacterInitial());

  Future<void> fetchCharacters() async {
    emit(CharacterLoading());
    try {
      final localCharacters = await getCharactersFromLocalDbUsecase.call();
      if (localCharacters.isNotEmpty) {
        emit(CharacterLoaded(localCharacters));
      } else {
        final remoteCharacters = await getCharactersFromServerUsecase.call();
        await updateDbUsecase.call(remoteCharacters);
        emit(CharacterLoaded(remoteCharacters));
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
      print('localCharacters[0].name');
      print(localCharacters[0].name);
      emit(CharacterLoaded(localCharacters));
    } on SocketException {
      print('No Internet connection');
      emit(CharacterError('No Internet connection'));
    } catch (e) {
      print('Failed to update database: $e');
      emit(CharacterError('Failed to update database: $e'));
    }
  }
}
