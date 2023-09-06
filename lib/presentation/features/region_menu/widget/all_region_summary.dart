import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class AllRegionSummary extends StatelessWidget {
  final RegionMenuData regionMenuData;
  AllRegionSummary({Key? key, required this.regionMenuData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableCoins = regionMenuData.availableCoins;
    final allRegionsTotalScore = regionMenuData.allRegionsTotalScore;

    final highestScoreName = regionMenuData.regionNameHighestHighestScore.key;
    final highestScoreValue = regionMenuData.regionNameHighestHighestScore.value;

    final highestAnsweredName = regionMenuData.regionNameHighestHighestAnswered.key;
    final highestAnsweredValue = regionMenuData.regionNameHighestHighestAnswered.value;

    final highestStreakName = regionMenuData.regionNameHighestHighestStreak.key;
    final highestStreakValue = regionMenuData.regionNameHighestHighestStreak.value;

    return Column(children: [
      Expanded(
          flex: 20,
          child: Container(
              color: Colors.black87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              const Spacer(flex: 1),
                                              Expanded(
                                                flex: 10,
                                                child: Image.asset('assets/images/coin_white.png'),
                                              ),
                                              const Spacer(flex: 1),
                                            ],
                                          ))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: SingleLineRetroText(
                                              text: availableCoins.toString(),
                                              color: Colors.amberAccent)))
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: SingleLineRetroText(text: "Your Summary", color: Colors.yellow),
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 12,
                      child: Row(
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: SingleLineRetroText(
                                                  text: "All region total score",
                                                  color: Colors.white)),
                                          Expanded(
                                              flex: 1,
                                              child: SingleLineRetroText(
                                                  text: allRegionsTotalScore.toString(),
                                                  color: Colors.orange))
                                        ],
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Column(children: [
                                      Expanded(
                                          flex: 1,
                                          child: SingleLineRetroText(
                                              text: "Highest score ($highestScoreName)",
                                              color: Colors.white)),
                                      Expanded(
                                          flex: 1,
                                          child: SingleLineRetroText(
                                              text: highestScoreValue.toString(),
                                              color: Colors.orange))
                                    ]),
                                  )
                                ],
                              )),
                          const Spacer(flex: 1),
                          Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: SingleLineRetroText(
                                                  text: "Highest answered ($highestAnsweredName)",
                                                  color: Colors.white)),
                                          Expanded(
                                              flex: 1,
                                              child: SingleLineRetroText(
                                                  text: highestAnsweredValue.toString(),
                                                  color: Colors.orange))
                                        ],
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Column(children: [
                                      Expanded(
                                          flex: 1,
                                          child: SingleLineRetroText(
                                              text: "Highest streak ($highestStreakName)",
                                              color: Colors.white)),
                                      Expanded(
                                          flex: 1,
                                          child: SingleLineRetroText(
                                              text: highestStreakValue.toString(),
                                              color: Colors.orange))
                                    ]),
                                  )
                                ],
                              )),
                          const Spacer(flex: 1),
                        ],
                      )),
                  const Spacer(flex: 2)
                ],
              ))),
      Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.black87)),
              const Spacer(flex: 8),
              Expanded(flex: 1, child: Container(color: Colors.black87)),
            ],
          )),
      Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.black87)),
              const Spacer(flex: 12),
              Expanded(flex: 1, child: Container(color: Colors.black87)),
            ],
          )),
      Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.black87)),
              const Spacer(flex: 18),
              Expanded(flex: 1, child: Container(color: Colors.black87)),
            ],
          )),
    ]);
  }
}
