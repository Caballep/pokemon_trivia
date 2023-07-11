import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_app_initial_data.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_states.dart';

class SplashCubit extends Cubit<SplashState> {
  final FetchInitialDataAndGetPokemonsUC _fetchInitialDataAndGetPokemonsUC;
  late List<SplashPokemon> _splashPokemonList;

  SplashCubit({
    required FetchInitialDataAndGetPokemonsUC fetchInitialDataAndGetPokemonsUC,
  })  : _fetchInitialDataAndGetPokemonsUC = fetchInitialDataAndGetPokemonsUC,
        super(SplashInitialState()) {
    _splashPokemonList = List.empty(growable: true);
  }

  Future<void> fetchPokemonData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await for (final pokemonModelResult in _fetchInitialDataAndGetPokemonsUC.invoke()) {
      if (pokemonModelResult is SuccessOutcome) {
        final pokemonModel = (pokemonModelResult as SuccessOutcome).data as PokemonModel;
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
