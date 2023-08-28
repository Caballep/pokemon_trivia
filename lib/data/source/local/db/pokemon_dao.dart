import 'package:pokemon_trivia/data/source/local/db/entity/generation_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_trivia_db.dart';

class PokemonDao {
  final PokemonTriviaDb pokemonTriviaDb;

  PokemonDao({required this.pokemonTriviaDb});

  Future<void> insertPokemon(PokemonEntity pokemon) async {
    final db = await pokemonTriviaDb.open();
    await db.insert(
      'pokemons',
      {
        'number': pokemon.number,
        'name': pokemon.name,
        'frontSpriteUrl': pokemon.frontSpriteUrl,
        'mainType': pokemon.mainType,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  Future<List<PokemonEntity>> getPokemons() async {
    final db = await pokemonTriviaDb.open();
    final queryMap = await db.query('pokemons');

    final pokemonList = queryMap.map((map) {
      return PokemonEntity(
        number: map['number'] as int,
        name: map['name'] as String,
        frontSpriteUrl: map['frontSpriteUrl'] as String,
        mainType: map['mainType'] as String,
      );
    }).toList();

    await db.close();

    return pokemonList;
  }

  Future<PokemonEntity?> getPokemonByNumber(int number) async {
    final db = await pokemonTriviaDb.open();
    final queryMap = await db.query(
      'pokemons',
      where: 'number = ?',
      whereArgs: [number],
      limit: 1,
    );

    if (queryMap.isEmpty) {
      return null;
    }

    final map = queryMap.first;
    db.close();
    return PokemonEntity(
      number: map['number'] as int,
      name: map['name'] as String,
      frontSpriteUrl: map['frontSpriteUrl'] as String,
      mainType: map['mainType'] as String,
    );
  }

  Future<int> getPokemonsCount() async {
    final db = await pokemonTriviaDb.open();
    final result = await db.rawQuery('SELECT COUNT(*) FROM pokemons');
    final count = Sqflite.firstIntValue(result);
    db.close();
    return count ?? 0;
  }

  Future<List<String>> getPokemonTypes() async {
    final db = await pokemonTriviaDb.open();
    final result = await db.rawQuery('SELECT DISTINCT mainType FROM pokemons');
    final types = result.map((row) => row['mainType'] as String).toList();
    db.close();
    return types;
  }

  Future<void> insertGeneration(GenerationEntity generation) async {
    final db = await pokemonTriviaDb.open();
    await db.insert(
      'generations',
      {
        'code': generation.code,
        'startsWith': generation.startsWith,
        'endsWith': generation.endsWith,
        'mainRegionName': generation.mainRegionName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  Future<List<GenerationEntity>> getGenerations() async {
    final db = await pokemonTriviaDb.open();
    final queryMap = await db.query('generations');

    final generationList = queryMap.map((map) {
      return GenerationEntity(
          code: map['code'] as String,
          startsWith: map['startsWith'] as int,
          endsWith: map['endsWith'] as int,
          mainRegionName: map['mainRegionName'] as String,
          acessState: GenerationEntityAccessState.getGenerationAccessStateFromInt(
              map['accessState'] as int));
    }).toList();

    await db.close();

    return generationList;
  }

  Future<GenerationEntity> getGeneration(String generationCode) async {
    final db = await pokemonTriviaDb.open();
    final queryMap = await db.query(
      'generations',
      where: 'code = ?',
      whereArgs: [generationCode],
      limit: 1,
    );

    await db.close();

    if (queryMap.isNotEmpty) {
      final map = queryMap.first;
      return GenerationEntity(
          code: map['code'] as String,
          startsWith: map['startsWith'] as int,
          endsWith: map['endsWith'] as int,
          mainRegionName: map['mainRegionName'] as String,
          acessState: GenerationEntityAccessState.getGenerationAccessStateFromInt(
              map['accessState'] as int));
    }
    throw Exception('Generation not found');
  }

  Future<void> updateGenerationPokemonsFetchedStatus(
      String generationCode, int generationAccessState) async {
    final db = await pokemonTriviaDb.open();
    await db.update(
      'generations',
      {'accessState': generationAccessState},
      where: 'code = ?',
      whereArgs: [generationCode],
    );
    db.close();
  }

  Future<void> setLastFetchedPokemon(String generationCode, int pokemonNumber) async {
    final db = await pokemonTriviaDb.open();

    final existingGeneration = await db.query(
      'generations',
      where: 'code = ?',
      whereArgs: [generationCode],
      limit: 1,
    );

    if (existingGeneration.isEmpty) {
      // Generation entry doesn't exist, insert it
      await db.insert(
        'generations',
        {'code': generationCode, 'lastFetchedPokemon': pokemonNumber},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } else {
      // Generation entry exists, update the lastFetchedPokemon field
      await db.update(
        'generations',
        {'lastFetchedPokemon': pokemonNumber},
        where: 'code = ?',
        whereArgs: [generationCode],
      );
    }

    db.close();
  }

  Future<int?> getLastFetchedPokemon(String generationCode) async {
    final db = await pokemonTriviaDb.open();

    final queryMap = await db.query(
      'generations',
      columns: ['lastFetchedPokemon'],
      where: 'code = ?',
      whereArgs: [generationCode],
      limit: 1,
    );

    await db.close();

    if (queryMap.isNotEmpty) {
      final map = queryMap.first;
      return map['lastFetchedPokemon'] as int?;
    }

    return null;
  }
}
