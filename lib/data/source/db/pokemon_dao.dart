import 'package:sqflite/sqflite.dart';

import 'package:pokemon_trivia/data/source/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/db/pokemon_db.dart';

class PokemonDao {
  final PokemonDb pokemonDb;

  PokemonDao(this.pokemonDb);

  Future<void> insertPokemon(PokemonEntity pokemon) async {
    final db = await pokemonDb.open();
    await db.insert(
      'pokemons',
      {
        'number': pokemon.number,
        'name': pokemon.name,
        'frontSprite': pokemon.frontSprite,
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
        frontSprite: map['frontSprite'] as String,
        mainType: map['mainType'] as String,
      );
    }).toList();
  }
}
