import 'package:effective_mobile/core/db/database_helper.dart';
import 'package:effective_mobile/features/character/character_injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Инициализация базы данных
  final dbHelper = DatabaseHelper();
  await dbHelper.initDB();
  sl.registerLazySingleton<DatabaseHelper>(() => dbHelper);
  sl.registerLazySingleton<Database>(() => dbHelper.database);

  await characterInjectionContainer();
}
