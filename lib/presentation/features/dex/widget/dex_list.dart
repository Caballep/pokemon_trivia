import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_data.dart';
import 'package:pokemon_trivia/presentation/features/dex/widget/dex_list_item.dart';

class DexList extends StatelessWidget {
  final List<PokemonDexData> pokemonDexData;

  const DexList({super.key, required this.pokemonDexData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.black87,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: pokemonDexData.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonDexData[index];
              if (index == 0) {
                return Container(
                    padding: const EdgeInsets.only(top: 12), child: DexListItem(pokemon));
              }
              return DexListItem(pokemon);
            },
          ),
        ));
  }
}
