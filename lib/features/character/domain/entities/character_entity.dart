class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final bool favorite; // Делаем final, чтобы объект оставался неизменяемым

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    this.favorite = false,
  });

  CharacterEntity copyWith({bool? favorite}) {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      image: image,
      favorite: favorite ?? this.favorite,
    );
  }
}

// class CharacterEntity {
//   final int id;
//   final String name;
//   final String status;
//   final String species;
//   final String image;
//   bool favorite;

//   CharacterEntity({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.species,
//     required this.image,
//     this.favorite = false,
//   });
// }
