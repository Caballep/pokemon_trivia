import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/check_pokemons_up_to_date_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/core/propagation/error.dart';

class SplashCubit extends Cubit<PokemonState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;
  final CheckPokemonsUpToDateUC _checkPokemonsUpToDateUC;

  SplashCubit({
    required FetchPokemonsUseCase fetchPokemonsUseCase,
    required CheckPokemonsUpToDateUC checkPokemonsUpToDateUC,
  })  : _fetchPokemonsUseCase = fetchPokemonsUseCase,
        _checkPokemonsUpToDateUC = checkPokemonsUpToDateUC,
        super(InitialState());

  Future<void> verifyDataAndFetch() async {
    emit(VerifyingState());
    final isPokemonsUpToDate = await _checkPokemonsUpToDateUC.invoke();
    if (isPokemonsUpToDate.isSuccess) {
      if (isPokemonsUpToDate.data == true) {
        emit(SplashLoadingCompleted());
        return;
      }
      fetchPokemonData();
    } else {
      handleError(isPokemonsUpToDate.error);
    }
  }

  Future<void> fetchPokemonData() async {
    await for (final pokemonModelResult in _fetchPokemonsUseCase.invoke()) {
      if (pokemonModelResult.isSuccess) {
        final pokemonModel = pokemonModelResult.data;
        if (pokemonModel != null) {
          emit(NewPokemonNameState(
              SplashPokemon.fromPokemonModel(pokemonModel)));
          return;
        }
      } else {
        handleError(pokemonModelResult.error);
      }
    }
  }

  void handleError(Error? error) {
    if (error == Error.noInternet || error == Error.genericNetwork) {
      emit(NetworkErrorState());
      return;
    }
    if (error == Error.timeOut || error == Error.serverIssue) {
      emit(ServerErrorState());
      return;
    }
    emit(UnknownErrorState());
  }
}

abstract class PokemonState {}

class InitialState extends PokemonState {}

class NewPokemonNameState extends PokemonState {
  final SplashPokemon splashPokemon;

  NewPokemonNameState(this.splashPokemon);
}

class VerifyingState extends PokemonState {}

class SplashLoadingCompleted extends PokemonState {}

class NetworkErrorState extends PokemonState {}

class ServerErrorState extends PokemonState {}

class UnknownErrorState extends PokemonState {}
