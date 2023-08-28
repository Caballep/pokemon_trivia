import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_states.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option.dart';

class RegionsMenuScreen extends StatefulWidget {
  final RegionMenuCubit _regionMenuCubit = locator.get<RegionMenuCubit>();
  RegionsMenuScreen({super.key}) {
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
              // Show what you already have
              return Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1 / 1.9,
                  ),
                  itemCount: state.regionMenuData.generationsCode.length,
                  itemBuilder: (context, index) {
                    return RegionOption(
                      generationCode: state.regionMenuData.generationsCode[index],
                    );
                  },
                ),
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
    );
  }
}
