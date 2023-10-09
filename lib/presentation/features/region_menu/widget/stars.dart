import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int number;
  const Stars(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStar(0),
        _buildStar(1),
        _buildStar(2),
      ],
    );
  }

  Widget _buildStar(int index) {
    if (index == 0) {
      if (number >= 2) {
        return Image.asset('assets/images/star_full.png');
      }
      if (number >= 1) {
        return Image.asset('assets/images/star_half.png');
      }
      return Image.asset('assets/images/star_empty.png');
    }

    if (index == 1) {
      if (number >= 4) {
        return Image.asset('assets/images/star_full.png');
      }
      if (number >= 3) {
        return Image.asset('assets/images/star_half.png');
      }
      return Image.asset('assets/images/star_empty.png');
    }

    if (index == 2) {
      if (number >= 6) {
        return Image.asset('assets/images/star_full.png');
      }
      if (number >= 5) {
        return Image.asset('assets/images/star_half.png');
      }
      return Image.asset('assets/images/star_empty.png');
    }

    return Image.asset('assets/images/star_empty.png');
  }
}
