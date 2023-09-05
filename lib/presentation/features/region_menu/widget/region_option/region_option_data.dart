import 'dart:io';

import 'package:pokemon_trivia/domain/model/region_option_detail_model.dart';

class RegionOptionLockedData {
  final String code;
  final int unlockCoinCost;

  RegionOptionLockedData({required this.code, required this.unlockCoinCost});

  factory RegionOptionLockedData.from(RegionOptionDetailModel detailModel) {
    return RegionOptionLockedData(
      code: detailModel.code,
      unlockCoinCost: detailModel.unlockCoinCost ?? 0,
    );
  }
}

class RegionOptionAvailableData {
  final String code;
  final String name;

  RegionOptionAvailableData({required this.code, required this.name});

  factory RegionOptionAvailableData.from(RegionOptionDetailModel detailModel) {
    return RegionOptionAvailableData(
      code: detailModel.code,
      name: detailModel.name,
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
