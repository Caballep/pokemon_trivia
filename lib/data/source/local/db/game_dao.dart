import 'package:pokemon_trivia/data/source/local/db/entity/game_score_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_trivia_db.dart';
import 'package:sqflite/sqflite.dart';

class GameDao {
  final PokemonTriviaDb pokemonTriviaDb;

  GameDao({required this.pokemonTriviaDb});

  Future<void> addCoins(int amount) async {
    final db = await pokemonTriviaDb.open();
    await db.execute('''
      INSERT OR REPLACE INTO coins (id, amount) VALUES (1, ?)
    ''', [amount]);
    db.close();
  }

  Future<void> subtractCoins(int amount) async {
    final db = await pokemonTriviaDb.open();
    final currentAmount = await getCoins();
    final newAmount = (currentAmount - amount).clamp(0, double.infinity).toInt();
    await db.execute('''
      INSERT OR REPLACE INTO coins (id, amount) VALUES (1, ?)
    ''', [newAmount]);

    db.close();
  }

  Future<int> getCoins() async {
    final db = await pokemonTriviaDb.open();
    final result = await db.rawQuery('SELECT amount FROM coins WHERE id = 1 LIMIT 1');
    if (result.isNotEmpty) {
      return result.first['amount'] as int;
    } else {
      return 0;
    }
  }

  Future<GameScoreEntity> getGameScore(String generationCode) async {
    final db = await pokemonTriviaDb.open();
    final result = await db.query(
      'game_scores',
      where: 'generationCode = ?',
      whereArgs: [generationCode],
      limit: 1,
    );

    db.close();

    if (result.isNotEmpty) {
      final row = result.first;
      return GameScoreEntity(
        generationCode: row['generationCode'] as String,
        highestScore: row['highestScore'] as int,
        highestAnswered: row['highestAnswered'] as int,
        highestStreak: row['highestStreak'] as int,
      );
    } else {
      return GameScoreEntity(
        generationCode: generationCode,
        highestScore: 0,
        highestAnswered: 0,
        highestStreak: 0,
      );
    }
  }

  Future<List<GameScoreEntity>> getAllGameScores() async {
    final db = await pokemonTriviaDb.open();
    final result = await db.query('game_scores');

    final gameScores = result
        .map((row) => GameScoreEntity(
              generationCode: row['generationCode'] as String,
              highestScore: row['highestScore'] as int,
              highestAnswered: row['highestAnswered'] as int,
              highestStreak: row['highestStreak'] as int,
            ))
        .toList();

    db.close();
    return gameScores;
  }

  Future<void> setGameScore(GameScoreEntity gameScore) async {
    final db = await pokemonTriviaDb.open();

    await db.insert(
      'game_scores',
      {
        'generationCode': gameScore.generationCode,
        'highestScore': gameScore.highestScore,
        'highestAnswered': gameScore.highestAnswered,
        'highestStreak': gameScore.highestStreak,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    db.close();
  }
}
