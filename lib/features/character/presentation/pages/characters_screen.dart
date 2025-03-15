import 'package:effective_mobile/features/character/presentation/cubits/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(builder: (context, state) {
      if (state is CharacterLoaded) {
        return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              return Text(state.characters[index].name);
            });
      }
      return Text('failed');
    });
  }
}
