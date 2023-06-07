import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_data.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';

class LoadingPokemonListItem extends StatelessWidget {
  final SplashPokemon splashPokemon;
  final LoadingPokemonListItemType loadingPokemonListItemType;

  const LoadingPokemonListItem(
      {super.key,
      required this.splashPokemon,
      required this.loadingPokemonListItemType});

  @override
  Widget build(BuildContext context) {
    final isBig = loadingPokemonListItemType == LoadingPokemonListItemType.big;
    final imageSize = isBig ? 130.0 : 60.0;
    final textSize = isBig ? 20.0 : 12.0;
    final textColor = isBig ? Colors.black87 : Colors.black54;
    final spacingBetween = isBig ? 0.0 : 10.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InDiskImageWidget(
          imageUrl: splashPokemon.frontSpriteUrl,
          width: imageSize,
          height: imageSize,
        ),
        SizedBox(width: spacingBetween),
        Text(
          splashPokemon.name,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ],
    );
  }
}

enum LoadingPokemonListItemType {
  big,
  small,
}
