import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';

class CoinCount extends StatefulWidget {
  final int availableCoins;
  final VoidCallback? onTapFiveTimes;

  CoinCount({
    required this.availableCoins,
    this.onTapFiveTimes,
  });

  @override
  _CoinCountState createState() => _CoinCountState();
}

class _CoinCountState extends State<CoinCount> {
  int tapCount = 0;
  late DateTime lastTapTime;

  @override
  void initState() {
    super.initState();
    lastTapTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
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
                text: widget.availableCoins.toString(),
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    final now = DateTime.now();
    final timeDiff = now.difference(lastTapTime);

    if (timeDiff <= const Duration(milliseconds: 500)) {
      tapCount++;
    } else {
      tapCount = 1;
    }

    lastTapTime = now;

    if (tapCount == 5 && widget.onTapFiveTimes != null) {
      widget.onTapFiveTimes!();
      tapCount = 0;
    }
  }
}
