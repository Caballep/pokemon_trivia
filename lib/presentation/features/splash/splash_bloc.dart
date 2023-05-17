import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/fetch_pokemons_uc.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';

class SplashCubit extends Cubit<PokemonState> {
  final FetchPokemonsUseCase fetchPokemonsUseCase;

  SplashCubit({required this.fetchPokemonsUseCase}) : super(InitialState());

  Future<void> fetchPokemons() async {
    //TODO: Have a queue to allow image cache complete download.
    try {
      await for (final pokemonModel in fetchPokemonsUseCase.invoke()) {
        emit(NewPokemonNameState(SplashPokemon.fromPokemonModel(pokemonModel)));
      }
      emit(CompletedState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}

abstract class PokemonState {}

class InitialState extends PokemonState {}

class NewPokemonNameState extends PokemonState {
  final SplashPokemon splashPokemon;

  NewPokemonNameState(this.splashPokemon);
}

class CompletedState extends PokemonState {}

class ErrorState extends PokemonState {}
