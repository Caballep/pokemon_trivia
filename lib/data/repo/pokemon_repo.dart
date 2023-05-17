import 'package:pokemon_trivia/data/source/local/storage/image_precache.dart';
import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class PokemonRepository {
  final PokemonDao pokemonDao;
  final PokemonApi pokemonApi;
  final DiskCacher diskCacher;

  PokemonRepository(
      {required this.pokemonDao,
      required this.pokemonApi,
      required this.diskCacher});

  Future<PokemonModel> fetchPokemon(int pokemonNumber) async {
    final pokemonDto = await pokemonApi.fetchPokemon(pokemonNumber);
    await diskCacher.cacheImage(pokemonDto.frontSpriteUrl);
    final pokemonEntity = PokemonEntity.fromDto(pokemonDto);
    await pokemonDao.insertPokemon(pokemonEntity);
    return PokemonModel.fromPokemonEntity(pokemonEntity);
  }

  Future<List<PokemonModel>> getAllPokemons() async {
    final pokemonEntities = await pokemonDao.getAllPokemons();
    return pokemonEntities
        .map((e) => PokemonModel.fromPokemonEntity(e))
        .toList();
  }

  Future<PokemonModel?> getPokemon(int pokemonNumber) async {
    final pokemonEntity = await pokemonDao.getPokemonByNumber(pokemonNumber);

    if (pokemonEntity != null) {
      return PokemonModel.fromPokemonEntity(pokemonEntity);
    } else {
      return null;
    }
  }
}
