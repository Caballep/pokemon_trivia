import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/widget/loading_pokemon_list_item.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';

class LoadingPokemonList extends StatelessWidget {
  final List<SplashPokemon> splashPokemonList;

  const LoadingPokemonList({Key? key, required this.splashPokemonList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final thisWidgetHeight = constraints.maxHeight;

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: splashPokemonList.length,
            itemBuilder: (context, index) {
              final loadingPokemonListItemType =
                  index == 0 ? LoadingPokemonListItemType.big : LoadingPokemonListItemType.small;
              final splashPokemon = splashPokemonList[index];
              return LoadingPokemonListItem(
                  splashPokemon: splashPokemon,
                  loadingPokemonListItemType: loadingPokemonListItemType,
                  loadingPokemonListHeight: thisWidgetHeight);
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white,
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
