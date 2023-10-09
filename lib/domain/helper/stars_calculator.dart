class StarsCalculator {
  static int getStarsByScore(int? score) {
    if (score == null) {
      return 0;
    } else {
      if (score > 500) {
        return 6;
      }
      if (score > 400) {
        return 5;
      }
      if (score > 300) {
        return 4;
      }
      if (score > 200) {
        return 3;
      }
      if (score > 100) {
        return 2;
      }
      if (score > 50) {
        return 1;
      }
      return 0;
    }
  }
}
