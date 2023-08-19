import 'package:pokemon_trivia/data/source/local/db/entity/game_score_entity.dart';

class GenerationScoreModel {
  final String generationCode;
  final int highestScore;
  final int highestStreak;
  final int highestAnswered;

  GenerationScoreModel(
      {required this.generationCode,
      required this.highestScore,
      required this.highestStreak,
      required this.highestAnswered});

  factory GenerationScoreModel.from(GameScoreEntity gameScoreEntity) {
    return GenerationScoreModel(
        generationCode: gameScoreEntity.generationCode,
        highestScore: gameScoreEntity.highestScore,
        highestStreak: gameScoreEntity.highestStreak,
        highestAnswered: gameScoreEntity.highestAnswered);
  }
}
