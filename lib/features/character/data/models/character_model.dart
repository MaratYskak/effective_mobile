import 'package:effective_mobile/features/character/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String image,
    bool favorite = false,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          image: image,
          favorite: favorite,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
      // favorite: json['favorite'] ?? false,
      favorite: (json['favorite'] as int?) == 1,
    );
  }

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? image,
    bool? favorite,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
      'favorite': favorite ? 1 : 0, // Сохранение как 0 или 1
    };
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      image: image,
    );
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      favorite: entity.favorite,
      status: entity.status,
      species: entity.species,
      image: entity.image,
    );
  }
}
