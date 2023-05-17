import 'package:sqflite/sqflite.dart';

import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_db.dart';

class PokemonDao {
  final PokemonDb pokemonDb;

  PokemonDao({required this.pokemonDb});

  Future<void> insertPokemon(PokemonEntity pokemon) async {
    final db = await pokemonDb.open();
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
  }

  Future<List<PokemonEntity>> getAllPokemons() async {
    final db = await pokemonDb.open();
    final maps = await db.query('pokemons');
    return maps.map((map) {
      return PokemonEntity(
        number: map['number'] as int,
        name: map['name'] as String,
        frontSpriteUrl: map['frontSpriteUrl'] as String,
        mainType: map['mainType'] as String,
      );
    }).toList();
  }

  Future<PokemonEntity?> getPokemonByNumber(int number) async {
    final db = await pokemonDb.open();
    final maps = await db.query(
      'pokemons',
      where: 'number = ?',
      whereArgs: [number],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return PokemonEntity(
      number: map['number'] as int,
      name: map['name'] as String,
      frontSpriteUrl: map['frontSpriteUrl'] as String,
      mainType: map['mainType'] as String,
    );
  }
}