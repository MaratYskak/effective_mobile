import 'package:effective_mobile/features/character/presentation/cubits/favorites/favorites_cubit.dart';
import 'package:effective_mobile/features/character/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // @override
  // void initState() {
  //   context.read<FavoritesCubit>().
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              final character = state.characters[index];
              return CharacterCard(character: character);
            },
          );
        }
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FavoritesEmpty) {
          return const Center(child: Text('empty'));
        }
        return const Center(child: Text('Failed to load characters'));
      },
    );
  }
}
