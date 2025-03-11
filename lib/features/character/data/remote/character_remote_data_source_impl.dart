import 'dart:convert';
import 'package:effective_mobile/features/character/data/models/character_model.dart';
import 'package:effective_mobile/features/character/data/remote/character_remote_data_source.dart';
import 'package:http/http.dart' as http;

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  @override
  Stream<List<CharacterModel>> getCharacters() async* {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      yield data.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
