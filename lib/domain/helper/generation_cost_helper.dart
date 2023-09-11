class GenerationCostHelper {
  static int getCostToUnlock(String generationCode) {
    final Map<String, int> costMap = {
      "II": 9,
      "III": 10,
      "IV": 12,
      "V": 15,
      "VI": 19,
      "VII": 24,
      "VIII": 30,
      "IX": 37,
    };

    return costMap[generationCode] ?? 45;
  }
}
