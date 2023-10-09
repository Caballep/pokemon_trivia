import 'package:flutter/material.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_cubit.dart';

class GameScreen extends StatefulWidget {
  final String regionCode;
  final RegionMenuCubit _regionMenuCubit;

  GameScreen({Key? key, required this.regionCode})
      : _regionMenuCubit = locator.get<RegionMenuCubit>(),
        super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(color: Colors.green),
    ));
  }
}
