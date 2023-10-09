import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/coin/coin_cubit.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class CoinCount extends StatefulWidget {
  final CoinCubit _coinCubit = locator.get<CoinCubit>();

  @override
  _CoinCountState createState() => _CoinCountState();
}

class _CoinCountState extends State<CoinCount> {
  @override
  void initState() {
    widget._coinCubit.getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget._coinCubit.handleEaterEggClick();
      },
      child: BlocBuilder<CoinCubit, CoinState>(
          bloc: widget._coinCubit,
          builder: (context, state) {
            if (state is CoinResultState) {
              return Container(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 10,
                            child: Image.asset('assets/images/coin_white.png'),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleLineRetroText(
                        text: state.coins.toString(),
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
