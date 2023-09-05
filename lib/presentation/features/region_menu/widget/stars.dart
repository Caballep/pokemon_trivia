import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int number;
  const Stars(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStar(0),
        _buildStar(1),
        _buildStar(2),
      ],
    );
  }

  Widget _buildStar(int index) {
    double starValue = number / 2;
    if (starValue >= index) {
      return Image.asset('assets/images/star_full.png');
    } else if (starValue >= index / 2) {
      return Image.asset('assets/images/star_half.png');
    } else {
      return Image.asset('assets/images/star_empty.png');
    }
  }
}
