import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String image,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          image: image,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }
}
