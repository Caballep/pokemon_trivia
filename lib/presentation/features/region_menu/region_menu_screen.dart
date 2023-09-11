import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_states.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/all_region_summary.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/coin_count.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option_page_view.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class RegionsMenuScreen extends StatefulWidget {
  final height = MediaQueryUtil.height;
  final RegionMenuCubit _regionMenuCubit = locator.get<RegionMenuCubit>();

  RegionsMenuScreen({Key? key}) : super(key: key) {
    _regionMenuCubit.getRegionsMenuModel();
  }

  @override
  State<RegionsMenuScreen> createState() => _RegionsMenuScreenState();
}

class _RegionsMenuScreenState extends State<RegionsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.grey[300],
        child: BlocBuilder<RegionMenuCubit, RegionMenuState>(
          bloc: widget._regionMenuCubit,
          builder: (context, state) {
            if (state is RegionMenuInitialState) {
              // Show Blank
              return Container();
            }

            if (state is RegionMenuLoadingState) {
              // Show Loading
              return const CircularProgressIndicator();
            }

            if (state is RegionMenuLoadedState) {
              final data = state.regionMenuData;

              return Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.black87,
                          child: Row(children: [
                            const Spacer(flex: 5),
                            Expanded(
                                flex: 1,
                                child: CoinCount(
                                  availableCoins: data.availableCoins,
                                  onTapFiveTimes: () {
                                    widget._regionMenuCubit.fireCoinEasterEgg();
                                  },
                                )),
                          ]))),
                  Expanded(flex: 8, child: AllRegionSummary(regionMenuData: data)),
                  Expanded(
                      flex: 20,
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 26, right: 26),
                                      child: SingleLineRetroText(
                                          text: "Tap on a region to start: ", color: Colors.white)),
                                  Container(
                                      padding: const EdgeInsets.only(left: 30, right: 30),
                                      child: SingleLineRetroText(
                                          text: "Tap on a region to start: ", color: Colors.black))
                                ],
                              )),
                          Expanded(
                            flex: 18,
                            child: RegionOptionPageView(
                              generationCodes: data.generationsCode,
                              onRegionClicked: (generationCode) {
                                print("Hey it works!");
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              );
            }

            if (state is RegionMenuErrorState) {
              // Show an error text
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            return Container(); // Default case
          },
        ),
      ),
    ));
  }
}
