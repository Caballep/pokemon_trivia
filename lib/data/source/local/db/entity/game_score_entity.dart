import 'package:pokemon_trivia/domain/model/region_score_model.dart';

class GameScoreEntity {
  final String generationCode;
  final int highestScore;
  final int highestAnswered;
  final int highestStreak;

  GameScoreEntity(
      {required this.generationCode,
      required this.highestScore,
      required this.highestAnswered,
      required this.highestStreak});

  factory GameScoreEntity.from(GenerationScoreModel regionScoreModel) {
    return GameScoreEntity(
        generationCode: regionScoreModel.generationCode,
        highestScore: regionScoreModel.highestScore,
        highestStreak: regionScoreModel.highestStreak,
        highestAnswered: regionScoreModel.highestAnswered);
  }
}
