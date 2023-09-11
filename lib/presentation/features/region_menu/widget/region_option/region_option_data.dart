import 'dart:io';

import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';

class RegionOptionLockedOrAvailableData {
  final String code;
  final String name;
  final int unlockCoinCost;
  final bool unlocked;

  RegionOptionLockedOrAvailableData({required this.code, required this.unlockCoinCost, required this.name, required this.unlocked});

  factory RegionOptionLockedOrAvailableData.from(RegionOptionDetailModel detailModel) {
    return RegionOptionLockedOrAvailableData(
      code: detailModel.code,
      name: detailModel.name,
      unlockCoinCost: detailModel.unlockCoinCost ?? 0,
      unlocked: detailModel.unlockCoinCost == null ? true : false
    );
  }
}

class RegionOptionReadyToPlayData {
  final String code;
  final String name;
  final List<File> displayPokemonImageFiles;
  final int firstPokemonNumber;
  final int lastPokemonNumber;
  final int highestScore;
  final int highestAnswered;
  final int highestStreak;
  final int stars;

  RegionOptionReadyToPlayData(
      {required this.code,
      required this.name,
      required this.displayPokemonImageFiles,
      required this.firstPokemonNumber,
      required this.lastPokemonNumber,
      required this.highestScore,
      required this.highestAnswered,
      required this.highestStreak,
      required this.stars});

  factory RegionOptionReadyToPlayData.from(RegionOptionDetailModel detailModel) {
    return RegionOptionReadyToPlayData(
        code: detailModel.code,
        name: detailModel.name,
        displayPokemonImageFiles: detailModel.displayPokemonImageFiles ?? [],
        firstPokemonNumber: detailModel.firstPokemonNumber,
        lastPokemonNumber: detailModel.lastPokemonNumber,
        highestScore: detailModel.highestScore ?? 0,
        highestAnswered: detailModel.highestAnswered ?? 0,
        highestStreak: detailModel.highestStreak ?? 0,
        stars: detailModel.stars ?? 0);
  }
}
