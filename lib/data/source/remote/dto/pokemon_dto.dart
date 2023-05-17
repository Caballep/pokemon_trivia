class PokemonDto {
  final int number;
  final String name;
  final String frontSpriteUrl;
  final String mainType;

  PokemonDto({
    required this.number,
    required this.name,
    required this.frontSpriteUrl,
    required this.mainType,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    final number = json['id'];
    final name = json['name'];
    final frontSpriteUrl = json['sprites']['front_default'];
    final mainType = json['types'][0]['type']['name'];

    return PokemonDto(
      number: number,
      name: name,
      frontSpriteUrl: frontSpriteUrl,
      mainType: mainType,
    );
  }
}
