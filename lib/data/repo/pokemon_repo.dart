import 'package:pokemon_trivia/data/source/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/model/pokemon.dart';

class PokemonRepository {
  final PokemonDao pokemonDao;
  final PokemonApi pokemonApi;

  PokemonRepository(this.pokemonDao, this.pokemonApi);

  Future<void> fetchPokemon(int pokemonNumber) async {
    final pokemonDto = await pokemonApi.fetchPokemon(pokemonNumber);
    final pokemonEntity = PokemonEntity.fromDto(pokemonDto);
    await pokemonDao.insertPokemon(pokemonEntity);
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final pokemonEntities = await pokemonDao.getAllPokemons();
    return pokemonEntities.map((e) => Pokemon.fromPokemonEntity(e)).toList();
  }

  Future<Pokemon?> getPokemon(int pokemonNumber) async {
    final pokemonEntity = await pokemonDao.getPokemonByNumber(pokemonNumber);

    if (pokemonEntity != null) {
      return Pokemon.fromPokemonEntity(pokemonEntity);
    } else {
      return null;
    }
  }
}
