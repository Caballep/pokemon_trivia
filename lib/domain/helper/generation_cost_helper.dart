class GenerationCostHelper {
  static int getCostToUnlock(String generationCode) {
    final Map<String, int> costMap = {
      "II": 9,
      "III": 12,
      "IV": 16,
      "V": 21,
      "VI": 27,
      "VII": 34,
      "VIII": 42,
      "IX": 51,
    };

    return costMap[generationCode] ?? 51;
  }
}
