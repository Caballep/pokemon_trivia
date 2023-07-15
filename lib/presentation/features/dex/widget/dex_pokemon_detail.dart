import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_data.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class DexPokemonDetail extends StatelessWidget {
  final PokemonDexData pokemonDexData;

  const DexPokemonDetail({Key? key, required this.pokemonDexData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: 350,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Container(
              color: pokemonDexData.color,
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                color: pokemonDexData.color,
              )),
          Container(
            padding: const EdgeInsets.all(40),
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Container(
              color: Colors.white,
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            InDiskImageWidget(imageUrl: pokemonDexData.frontSpriteUrl, width: 110, height: 110),
            RetroText(
              text: '#${pokemonDexData.number}',
              fontSize: 36,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            RetroText(
              text: pokemonDexData.name,
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            RetroText(
              text: 'Generation ${pokemonDexData.generationCode}',
              fontSize: 20,
              color: Colors.black,
            ),
            RetroText(
              text: '${pokemonDexData.regionName} region',
              fontSize: 20,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            RetroText(
              text: '-|${pokemonDexData.mainType}|-',
              fontSize: 30,
              color: pokemonDexData.color,
            ),
          ])
        ]));
  }
}
