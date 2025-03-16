import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:effective_mobile/features/character/presentation/cubits/characters/character_cubit.dart';
import 'package:effective_mobile/features/character/presentation/cubits/favorites/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(character.image, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(character.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("Status: ${character.status}",
            style: TextStyle(
              color: character.status == 'Alive' ? Colors.green : Colors.red,
            )),
        trailing: IconButton(
          icon: Icon(
            character.favorite ? Icons.star : Icons.star_border,
            color: character.favorite ? Colors.yellow : Colors.white,
          ),
          onPressed: () {
            context.read<CharacterCubit>().toggleFavorite(characterId: character.id, isFavorite: !character.favorite);
            context.read<FavoritesCubit>().fetchCharacters();
          },
        ),
      ),
    );
  }
}
