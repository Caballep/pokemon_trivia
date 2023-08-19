import 'dart:io';

import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/region_score_model.dart';
import 'package:pokemon_trivia/domain/model/regions_menu_model.dart';

// This represents the data that will be used to feed the RegionMenuScreen
class RegionMenuData {
  final int availableCoins;
  final int allRegionsTotalScore;
  final MapEntry<String, int> regionNameHighestHighestScore;
  final MapEntry<String, int> regionNameHighestHighestStreak;
  final MapEntry<String, int> regionNameHighestHighestAnswered;
  final List<String> generationsCode;

  RegionMenuData({
    required this.availableCoins,
    required this.allRegionsTotalScore,
    required this.regionNameHighestHighestScore,
    required this.regionNameHighestHighestStreak,
    required this.regionNameHighestHighestAnswered,
    required this.generationsCode,
  });

  factory RegionMenuData.from(
    RegionsAndScoresModel regionsAndScoresModel,
    int coins,
  ) {
    return RegionMenuData(
      availableCoins: coins,
      allRegionsTotalScore: regionsAndScoresModel.allRegionsTotalScore,
      regionNameHighestHighestScore: regionsAndScoresModel.regionNameHighestHighestScore,
      regionNameHighestHighestStreak: regionsAndScoresModel.regionNameHighestHighestStreak,
      regionNameHighestHighestAnswered: regionsAndScoresModel.regionNameHighestHighestAnswered,
      generationsCode: regionsAndScoresModel.generationsCode,
    );
  }
}

// This represents the data to feed each individual RegionOption
class RegionOptionData {
  final String code;
  final String name;
  final List<File> displayPokemonImageFiles;
  final int firstPokemonNumber;
  final int lastPokemonNumber;
  final int highestScore;
  final int highestAnswered;
  final int highestStreak;

  RegionOptionData(
      {required this.code,
      required this.name,
      required this.displayPokemonImageFiles,
      required this.firstPokemonNumber,
      required this.lastPokemonNumber,
      required this.highestScore,
      required this.highestAnswered,
      required this.highestStreak});

  factory RegionOptionData.from(GenerationModel generationModel,
      GenerationScoreModel generationScoreModel, List<File> threeIconicRegionPokemons) {
    return RegionOptionData(
        code: generationModel.code,
        name: generationModel.mainRegionName,
        displayPokemonImageFiles: threeIconicRegionPokemons,
        firstPokemonNumber: generationModel.startsWith,
        lastPokemonNumber: generationModel.endsWith,
        highestScore: generationScoreModel.highestScore,
        highestAnswered: generationScoreModel.highestAnswered,
        highestStreak: generationScoreModel.highestStreak);
  }
}
