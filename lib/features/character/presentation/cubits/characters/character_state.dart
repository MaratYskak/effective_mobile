part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();
}

class CharacterInitial extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterLoading extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  const CharacterLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
