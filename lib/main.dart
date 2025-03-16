import 'package:effective_mobile/features/app/home/home_page.dart';
import 'package:effective_mobile/features/app/theme/style.dart';
import 'package:effective_mobile/features/character/presentation/cubits/characters/character_cubit.dart';
import 'package:effective_mobile/features/character/presentation/cubits/favorites/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<CharacterCubit>()
            ..fetchCharacters()
            ..updateDB(),
        ),
        BlocProvider(create: (context) => di.sl<FavoritesCubit>()..fetchCharacters()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: tabColor, brightness: Brightness.dark),
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: appBarColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
