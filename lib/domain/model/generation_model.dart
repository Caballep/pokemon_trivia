import 'package:pokemon_trivia/data/source/local/db/entity/generation_entity.dart';

class GenerationModel {
  final String code;
  final int startsWith;
  final int endsWith;
  final String mainRegionName;
  final GenerationAccessState accessState;

  GenerationModel(
      {required this.code,
      required this.startsWith,
      required this.endsWith,
      required this.mainRegionName,
      required this.accessState});

  factory GenerationModel.from(GenerationEntity generationEntity) {
    final accessState = GenerationAccessState.from(generationEntity.acessState);

    return GenerationModel(
        code: generationEntity.code,
        startsWith: generationEntity.startsWith,
        endsWith: generationEntity.endsWith,
        mainRegionName: generationEntity.mainRegionName,
        accessState: accessState);
  }

  static List<GenerationModel> fromList(List<GenerationEntity> generationEntities) {
    return generationEntities.map((generationEntity) {
      final accessState = GenerationAccessState.from(generationEntity.acessState);

      return GenerationModel(
          code: generationEntity.code,
          startsWith: generationEntity.startsWith,
          endsWith: generationEntity.endsWith,
          mainRegionName: generationEntity.mainRegionName,
          accessState: accessState);
    }).toList();
  }
}

enum GenerationAccessState {
  locked,
  available,
  pokemonsFetched;

  static GenerationAccessState from(GenerationEntityAccessState generationEntityAccessState) {
    switch (generationEntityAccessState) {
      case GenerationEntityAccessState.locked:
        return locked;
      case GenerationEntityAccessState.available:
        return available;
      case GenerationEntityAccessState.pokemonsFetched:
        return pokemonsFetched;
    }
  }
}
