import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/characters/character_cubit.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              final character = state.characters[index];
              return CharacterCard(character: character);
            },
          );
        }
        if (state is CharacterLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('Failed to load characters'));
      },
    );
  }
}

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
            debugPrint('character.favorite');
            debugPrint(character.favorite.toString());
            context.read<CharacterCubit>().toggleFavorite(characterId: character.id, isFavorite: !character.favorite);
          },
        ),
      ),
    );
  }
}
