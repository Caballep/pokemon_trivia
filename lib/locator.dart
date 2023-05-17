import 'package:get_it/get_it.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_dao.dart';
import 'package:pokemon_trivia/data/source/local/db/pokemon_db.dart';
import 'package:pokemon_trivia/data/source/local/storage/image_precache.dart';
import 'package:pokemon_trivia/data/source/remote/api/pokemon_api.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(PokemonDb());
  locator.registerSingleton(PokemonApi());
  locator.registerFactory(() => DiskCacher());
  locator.registerSingleton(PokemonDao(pokemonDb: locator.get<PokemonDb>()));
  locator.registerSingleton(PokemonRepository(
      pokemonApi: locator.get<PokemonApi>(),
      pokemonDao: locator.get<PokemonDao>(),
      diskCacher: locator.get<DiskCacher>()));
  locator.registerSingleton(FetchPokemonsUseCase(
      pokemonRepository: locator.get<PokemonRepository>()));
  locator.registerFactory(() =>
      SplashCubit(fetchPokemonsUseCase: locator.get<FetchPokemonsUseCase>()));
}
