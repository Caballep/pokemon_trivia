import 'dart:io';

import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';

class RegionOptionDetailModel {
  final String code;
  final String name;
  final List<File>? displayPokemonImageFiles;
  final int firstPokemonNumber;
  final int lastPokemonNumber;
  final int? highestScore;
  final int? highestAnswered;
  final int? highestStreak;
  final int? unlockCoinCost;
  final GenerationAccessState generationAccessState;

  RegionOptionDetailModel(
      {required this.code,
      required this.name,
      required this.displayPokemonImageFiles,
      required this.firstPokemonNumber,
      required this.lastPokemonNumber,
      required this.highestScore,
      required this.highestAnswered,
      required this.highestStreak,
      required this.unlockCoinCost,
      required this.generationAccessState});

  factory RegionOptionDetailModel.from(
      GenerationModel generationModel,
      GenerationScoreModel? generationScoreModel,
      List<File>? threeIconicRegionPokemons,
      int? unlockCoinCost) {
    return RegionOptionDetailModel(
        code: generationModel.code,
        name: generationModel.mainRegionName,
        displayPokemonImageFiles: threeIconicRegionPokemons,
        firstPokemonNumber: generationModel.startsWith,
        lastPokemonNumber: generationModel.endsWith,
        highestScore: generationScoreModel?.highestScore,
        highestAnswered: generationScoreModel?.highestAnswered,
        highestStreak: generationScoreModel?.highestStreak,
        unlockCoinCost: unlockCoinCost,
        generationAccessState: generationModel.accessState);
  }
}
