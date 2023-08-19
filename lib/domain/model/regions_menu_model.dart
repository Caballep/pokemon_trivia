class RegionsAndScoresModel {
  final int allRegionsTotalScore;
  final MapEntry<String, int> regionNameHighestHighestScore;
  final MapEntry<String, int> regionNameHighestHighestStreak;
  final MapEntry<String, int> regionNameHighestHighestAnswered;
  final List<String> generationsCode;

  RegionsAndScoresModel(
      {required this.allRegionsTotalScore,
      required this.regionNameHighestHighestScore,
      required this.regionNameHighestHighestStreak,
      required this.regionNameHighestHighestAnswered,
      required this.generationsCode});
}
