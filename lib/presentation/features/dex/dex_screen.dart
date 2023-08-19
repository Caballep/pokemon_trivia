import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_cubit.dart';
import 'package:pokemon_trivia/presentation/features/dex/dex_states.dart';
import 'package:pokemon_trivia/presentation/features/dex/widget/dex_filters.dart';
import 'package:pokemon_trivia/presentation/features/dex/widget/dex_list.dart';

class DexScreen extends StatefulWidget {
  DexScreen({Key? key}) : super(key: key);

  @override
  _DexScreenState createState() => _DexScreenState();
}

class _DexScreenState extends State<DexScreen> {
  final DexCubit _dexCubit = locator.get<DexCubit>();
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dexCubit.getAllPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DexCubit, DexState>(
          bloc: _dexCubit,
          builder: (context, state) {
            if (state is DexOnGetPokemonsState) {
              return Column(
                children: [
                  DexFilters(onValueChanged: _dexCubit.filterInputted),
                  Expanded(
                    child: DexList(pokemonDexData: state.pokemonDexDataList),
                  ),
                ],
              );
            } else if (state is DexErrorState) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Error. Tap to go back'),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dexCubit.close();
    _filterController.dispose();
    super.dispose();
  }
}
