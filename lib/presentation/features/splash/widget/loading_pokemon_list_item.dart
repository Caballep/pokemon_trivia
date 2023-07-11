import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class LoadingPokemonListItem extends StatelessWidget {
  final SplashPokemon splashPokemon;
  final LoadingPokemonListItemType loadingPokemonListItemType;
  final double loadingPokemonListHeight;

  const LoadingPokemonListItem(
      {Key? key,
      required this.splashPokemon,
      required this.loadingPokemonListItemType,
      required this.loadingPokemonListHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.black54;
    final isBig = loadingPokemonListItemType == LoadingPokemonListItemType.big;
    final imageSize = isBig ? loadingPokemonListHeight * 0.25 : loadingPokemonListHeight * 0.15;
    final textSize = isBig ? loadingPokemonListHeight * 0.10 : loadingPokemonListHeight * 0.06;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: imageSize,
          height: imageSize,
          child: InDiskImageWidget(
            width: imageSize,
            height: imageSize,
            imageUrl: splashPokemon.frontSpriteUrl,
          ),
        ),
        RetroText(
          text: splashPokemon.name,
          color: textColor,
          fontSize: textSize,
        ),
      ],
    );
  }
}

enum LoadingPokemonListItemType {
  big,
  small,
}
