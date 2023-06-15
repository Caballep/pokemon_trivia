class GameScoreEntity {
  final String generation;
  final int higherScore;
  final int totalAsserts;

  GameScoreEntity(
      {required this.generation,
      required this.higherScore,
      required this.totalAsserts});
}
