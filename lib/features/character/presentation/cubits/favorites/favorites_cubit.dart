import 'package:bloc/bloc.dart';
import 'package:effective_mobile/features/character/data/models/character_model.dart';
import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/domain/usecases/get_favorites_usecase.dart';
import 'package:effective_mobile/features/character/domain/usecases/toggle_favorite_usecase.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUsecase getFavoritesUsecase;
  final ToggleFavoriteUsecase toggleFavoriteUsecase;
  FavoritesCubit({
    required this.getFavoritesUsecase,
    required this.toggleFavoriteUsecase,
  }) : super(FavoritesInitial());

  Future<void> toggleFavorite({required int characterId, required bool isFavorite}) async {
    await toggleFavoriteUsecase.call(characterId, isFavorite);

    // Обновляем список персонажей в состоянии
    final updatedCharacters = (state as FavoritesLoaded).characters.map((character) {
      if (character.id == characterId) {
        final characterModel = CharacterModel.fromEntity(character);
        return characterModel.copyWith(favorite: isFavorite);
      }
      final characterModel = CharacterModel.fromEntity(character);
      return characterModel;
    }).toList();

    emit(FavoritesLoaded(updatedCharacters));
  }

  Future<void> fetchCharacters() async {
    emit(FavoritesLoading());
    try {
      final localCharacters = await getFavoritesUsecase.call();
      if (localCharacters.isNotEmpty) {
        emit(FavoritesLoaded(localCharacters));
      } else {
        emit(FavoritesEmpty());
      }
    } catch (e) {
      emit(FavoritesError('Failed to load characters: $e'));
    }
  }
}
