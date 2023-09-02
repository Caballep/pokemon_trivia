import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_state.dart';
import 'package:pokemon_trivia/presentation/shared/Image_sticker.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:pokemon_trivia/presentation/utils/color_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionOptionCubit, RegionOptionState>(
        bloc: widget.regionOptionCubit,
        builder: (context, state) {
          if (state is RegionOptionReadyToPlayState) {
            final data = state.regionOptionData;
            final color = ColorProvider.getColorFromGenerationCode(data.code);
            return GestureDetector(
              onTap: () {
                widget.onRegionClicked(widget.generationCode);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RegionOptionSurface(color: color),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      MultiLineRetroText(text: data.code, color: Colors.black, fontSize: 60.0),
                      MultiLineRetroText(text: data.name, color: Colors.white, fontSize: 35.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChangingImageSticker(
                              displayPokemonImageFiles: data.displayPokemonImageFiles, size: 135)
                        ],
                      ),
                      Container(
                        child: SingleLineRetroText(
                            text: "From ${data.firstPokemonNumber} to ${data.lastPokemonNumber}",
                            color: Colors.black),
                        padding: EdgeInsets.only(left: 30, right: 30),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              MultiLineRetroText(
                                  text: "Score: ${data.highestScore}",
                                  color: Colors.black,
                                  fontSize: 35.0),
                              MultiLineRetroText(
                                  text: "Answered: ${data.highestAnswered}",
                                  color: Colors.black,
                                  fontSize: 35.0),
                              MultiLineRetroText(
                                  text: "Streak: ${data.highestStreak}",
                                  color: Colors.black,
                                  fontSize: 35.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: MultiLineRetroText(text: "XXX", color: Colors.yellow, fontSize: 60.0),
                  )
                ],
              ),
            );
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.amber,
          );
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
