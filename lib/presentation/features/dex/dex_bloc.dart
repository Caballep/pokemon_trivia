import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/detailed_pokemon_model.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/get_detailed_pokemons.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_data.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_states.dart';
import 'package:pokemon_trivia/presentation/utils/pokemon_color_type_util.dart';

class DexCubit extends Cubit<DexState> {
  final GetDetailedPokemonsUC _getAllPokemonsUC;
  late List<PokemonDexData> pokemonDexDataList;

  DexCubit({required GetDetailedPokemonsUC getAllPokemonsUC})
      : _getAllPokemonsUC = getAllPokemonsUC,
        super(DexInitialState());

  Future<void> getAllPokemons() async {
    final outcome = await _getAllPokemonsUC.invoke();
    if (outcome is ErrorOutcome) {
      emit(DexErrorState());
      return;
    }

    final detailedPokemons = (outcome as SuccessOutcome).data as List<DetailedPokemonModel>;
    pokemonDexDataList = detailedPokemons
        .map((p) => PokemonDexData(p.number, p.name, p.frontSpriteUrl, p.mainType, p.generationCode,
            p.regionName, PokemonColorTypeUtil.getColorFromType(p.mainType)))
        .toList();

    emit(DexOnGetPokemonsState(pokemonDexDataList));
  }

  Future<void> filterInputted(String filterText) async {
    if (filterText.isEmpty) {
      emit(DexOnGetPokemonsState(pokemonDexDataList));
      return;
    }

    final numericRegex = RegExp(r'^[0-9]+$');
    if (numericRegex.hasMatch(filterText)) {
      final filteredListByNumber = pokemonDexDataList
          .where((pokemon) => pokemon.number.toString().startsWith(filterText))
          .toList();
      emit(DexOnGetPokemonsState(filteredListByNumber));
      return;
    }

    final filteredListByName = pokemonDexDataList
        .where((pokemon) => pokemon.name.toLowerCase().startsWith(filterText.toLowerCase()))
        .toList();
    emit(DexOnGetPokemonsState(filteredListByName));
  }
}
