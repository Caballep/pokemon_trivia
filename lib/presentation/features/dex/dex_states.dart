import 'package:pokemon_trivia/presentation/features/dex/dex_data.dart';

abstract class DexState {}

class DexInitialState extends DexState {}

class DexOnGetPokemonsState extends DexState {
  final List<PokemonDexData> pokemonDexDataList;

  DexOnGetPokemonsState(this.pokemonDexDataList);
}

class DexErrorState extends DexState {}
