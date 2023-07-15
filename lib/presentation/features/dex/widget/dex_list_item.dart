import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_data.dart';
import 'package:pokemon_trivia/presentation/features/dex/widget/dex_pokemon_detail.dart';
import 'package:pokemon_trivia/presentation/shared/cached_image.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class DexListItem extends StatelessWidget {
  final PokemonDexData _pokemonDexData;

  const DexListItem(PokemonDexData pokemonDexData, {super.key}) : _pokemonDexData = pokemonDexData;

  @override
  Widget build(BuildContext context) {
    final text = " #${_pokemonDexData.number} ${_pokemonDexData.name}";
    return Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: GestureDetector(
            onTap: () {
              _showDexPokemonDetailDialog(context, _pokemonDexData);
            },
            child: SizedBox(
                width: double.infinity,
                height: 80,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        color: _pokemonDexData.color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        color: _pokemonDexData.color,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 2, left: 2),
                                child: InDiskImageWidget(
                                  colorize: Colors.black,
                                  width: 80,
                                  height: 80,
                                  imageUrl: _pokemonDexData.frontSpriteUrl,
                                )),
                            Container(
                                padding: const EdgeInsets.only(bottom: 2, right: 2),
                                child: InDiskImageWidget(
                                  colorize: Colors.white,
                                  width: 80,
                                  height: 80,
                                  imageUrl: _pokemonDexData.frontSpriteUrl,
                                )),
                            Container(
                                padding: const EdgeInsets.only(bottom: 3, right: 3),
                                child: InDiskImageWidget(
                                  width: 65,
                                  height: 65,
                                  imageUrl: _pokemonDexData.frontSpriteUrl,
                                )),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 2, left: 2),
                              child: RetroText(
                                text: text,
                                color: Colors.black,
                                fontSize: 32,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 3, right: 3),
                              child: RetroText(
                                text: text,
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ))));
  }

  void _showDexPokemonDetailDialog(BuildContext context, PokemonDexData pokemonDexData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeInOut,
          )),
          child: AlertDialog(
            content: DexPokemonDetail(pokemonDexData: pokemonDexData),
            backgroundColor: Colors.transparent,
          ),
        );
      },
    );
  }
}
