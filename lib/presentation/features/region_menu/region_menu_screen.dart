import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_cubit.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_states.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option.dart';

class RegionsMenuScreen extends StatefulWidget {
  final RegionMenuCubit _regionMenuCubit = locator.get<RegionMenuCubit>();
  RegionsMenuScreen({super.key});

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
            return Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 1 / 1.65,
                ),
                itemCount: 20, // 10 Containers per column (2 columns, total 20)
                itemBuilder: (context, index) {
                  return RegionOption(
                    generationCode: (state as RegionMenuLoadedState).regionMenuData.generationsCode[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
