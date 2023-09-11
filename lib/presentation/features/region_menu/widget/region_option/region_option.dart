import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/stars.dart';
import 'package:pokemon_trivia/presentation/shared/Image_sticker.dart';
import 'package:pokemon_trivia/presentation/shared/retro_button.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:pokemon_trivia/presentation/utils/color_provider.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class RegionOption extends StatefulWidget {
  final String generationCode;
  final Function(String generationCode) onRegionClicked;
  final RegionOptionCubit regionOptionCubit = locator.get<RegionOptionCubit>();
  RegionOption({Key? key, required this.generationCode, required this.onRegionClicked})
      : super(key: key) {
    regionOptionCubit.getRegionModel(generationCode);
  }

  @override
  State<RegionOption> createState() => _RegionOptionState();
}

class _RegionOptionState extends State<RegionOption> {
  final height = MediaQueryUtil.height;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionOptionCubit, RegionOptionState>(
        bloc: widget.regionOptionCubit,
        builder: (context, state) {
          // RegionOptionReadyToPlayState ----------------
          if (state is RegionOptionReadyToPlayState) {
            final data = state.regionOptionData;
            final color = ColorProvider.getColorFromGenerationCode(data.code);
            return GestureDetector(
              onTap: () {
                widget.onRegionClicked(widget.generationCode);
              },
              child: Column(children: [
                Expanded(
                    flex: 20,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        RegionOptionSurface(color: color),
                        Column(
                          children: [
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 3,
                              child: SingleLineRetroText(text: data.code, color: Colors.black),
                            ),
                            Expanded(
                                flex: 3,
                                child: SingleLineRetroText(text: data.name, color: Colors.white)),
                            Expanded(
                                flex: 6,
                                child: ChangingImageSticker(
                                    displayPokemonImageFiles: data.displayPokemonImageFiles,
                                    size: (height * 0.20))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 30, right: 30),
                                  child: SingleLineRetroText(
                                      text:
                                          "From #${data.firstPokemonNumber} to #${data.lastPokemonNumber}",
                                      color: Colors.white),
                                )),
                            Expanded(
                                flex: 4,
                                child: Row(children: [
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: RetroButton(
                                        color: Colors.lightGreen[500]!,
                                        pressedColor: Colors.lightGreen[700]!,
                                        height: height * 0.07,
                                        text: "Start",
                                        width: double.infinity,
                                        iconAssetString: 'assets/images/start.png',
                                        onTapUp: () {},
                                      )),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                ])),
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                color: Colors.white,
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: HighestText(
                                              text: 'Highest score: ',
                                              score: data.highestScore,
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: HighestText(
                                              text: 'Highest answered: ',
                                              score: data.highestAnswered,
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: HighestText(
                                              text: 'Highest streak: ',
                                              score: data.highestStreak,
                                            )),
                                        const Spacer(flex: 1),
                                        Expanded(flex: 3, child: Stars(data.stars)),
                                        const Spacer(flex: 1),
                                      ],
                                    )),
                              ),
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      ],
                    )),
              ]),
            );
          }
          // RegionOptionAvailableState ----------------------
          if (state is RegionOptionLockedOrAvailableState) {
            final data = state.regionOptionData;
            return Stack(
              alignment: Alignment.center,
              children: [
                RegionOptionSurface(color: Colors.grey[800]!),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 3,
                      child: SingleLineRetroText(text: data.code, color: Colors.grey),
                    ),
                    Expanded(
                      flex: 3,
                      child: SingleLineRetroText(text: data.name, color: Colors.white),
                    ),
                    const Spacer(
                      flex: 7,
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: RetroButton(
                            color: data.unlocked ? Colors.blue[700]! : Colors.yellow[700]!,
                            pressedColor: data.unlocked ? Colors.blue[800]! : Colors.yellow[800]!,
                            height: height * 0.075,
                            text: data.unlocked ? 'Download' : 'Unlock',
                            width: double.infinity,
                            iconAssetString: data.unlocked
                                ? 'assets/images/download.png'
                                : 'assets/images/confirm.png',
                            onTapUp: () {
                              if (data.unlocked) {
                                // Download
                              } else {
                                // Purchase
                                widget.regionOptionCubit.unlockRegion(widget.generationCode);
                              }
                            },
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 2,
                      child: data.unlocked
                          ? SingleLineRetroText(
                              text: 'Internet is required', color: Colors.blue[500]!)
                          : SingleLineRetroText(text: 'Unlock cost: ', color: Colors.amber[600]!),
                    ),
                    if (data.unlocked)
                      const Spacer(flex: 2)
                    else
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Spacer(flex: 3),
                            Expanded(
                              flex: 1,
                              child: Image.asset('assets/images/coin_black.png'),
                            ),
                            Expanded(
                              flex: 1,
                              child: SingleLineRetroText(
                                text: data.unlockCoinCost.toString(),
                                color: Colors.amberAccent,
                              ),
                            ),
                            const Spacer(flex: 3),
                          ],
                        ),
                      ),
                    const Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              ],
            );
          }

          return const RegionOptionSurface(color: Colors.grey);
        });
  }
}

// The background of the option
class RegionOptionSurface extends StatelessWidget {
  final Color color;
  const RegionOptionSurface({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 26, bottom: 25),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: color,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 13, left: 13, right: 13, bottom: 25),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: color,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 26, right: 26, bottom: 25),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: color,
          ),
        )
      ],
    );
  }
}

class HighestText extends StatelessWidget {
  final String text;
  final int score;

  const HighestText({super.key, required this.text, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 4,
          child: Container(
              alignment: Alignment.centerRight,
              child: SingleLineRetroText(
                text: text,
                color: Colors.black,
              ))),
      Expanded(
          flex: 1,
          child: Container(
              alignment: Alignment.topLeft,
              child: SingleLineRetroText(
                text: score.toString(),
                color: Colors.orange,
              ))),
    ]);
  }
}
