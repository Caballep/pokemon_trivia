import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_app_initial_data_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_states.dart';

class SplashCubit extends Cubit<SplashState> {
  final FetchInitialDataAndGetPokemonsUC _fetchInitialDataAndGetPokemonsUC;
  final FetchPokemonsUC _fetchPokemonsUC;
  late List<SplashPokemon> _splashPokemonList;

  SplashCubit(
      {required FetchInitialDataAndGetPokemonsUC fetchInitialDataAndGetPokemonsUC,
      required FetchPokemonsUC fetchPokemonsUC})
      : _fetchInitialDataAndGetPokemonsUC = fetchInitialDataAndGetPokemonsUC,
        _fetchPokemonsUC = fetchPokemonsUC,
        super(SplashInitialState()) {
    _splashPokemonList = List.empty(growable: true);
  }

  Future<void> fetchPokemonData(String? generationCode) async {
    late Stream<Outcome<PokemonModel?>> pokemonModel;

    if (generationCode == null) {
      pokemonModel = _fetchInitialDataAndGetPokemonsUC.invoke();
    } else {
      pokemonModel = _fetchPokemonsUC.invoke(generationCode);
    }

    await for (final pokemonModelResult in pokemonModel) {
      if (pokemonModelResult is SuccessOutcome) {
        final pokemonModelData = (pokemonModelResult as SuccessOutcome).data;
        if (pokemonModelData == null) {
          emit(SplashLoadingCompletedState());
          return;
        }
        final pokemonModel = pokemonModelData as PokemonModel;
        _updateSplashPokemonList(SplashPokemon.fromPokemonModel(pokemonModel));
        emit(SplashOnNextPokemonState(_splashPokemonList));
      } else {
        final errorOutcome = pokemonModelResult as ErrorOutcome;
        _handleInitiatFetchError(errorOutcome.error);
        return;
      }
    }
    emit(SplashLoadingCompletedState());
  }

  void _updateSplashPokemonList(SplashPokemon splashPokemon) {
    if (_splashPokemonList.length >= 5) {
      _splashPokemonList.removeLast();
    }
    _splashPokemonList.insert(0, splashPokemon);
  }

  void _handleInitiatFetchError(Errors? error) {
    if (error == Errors.noInternet || error == Errors.genericNetwork) {
      emit(SplashNetworkErrorState());
      return;
    }
    if (error == Errors.timeOut || error == Errors.serverIssue) {
      emit(SplashServerErrorState());
      return;
    }
    if (error == Errors.timeOut || error == Errors.serverIssue) {
      emit(SplashServerErrorState());
      return;
    }
    if (error == Errors.nullItem || error == Errors.errorInItem) {
      emit(SplashStreamItemErrorState());
      return;
    }
    emit(SplashUnknownErrorState());
  }
}
