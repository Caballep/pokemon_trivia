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
