class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  bool favorite;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    this.favorite = false,
  });
}
