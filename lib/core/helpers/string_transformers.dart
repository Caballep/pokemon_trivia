String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input.substring(0, 1).toUpperCase() + input.substring(1);
}

/// Gets the number from a url where the number is at the end of it in between /
/// Example Input: https://pokeapi.co/api/v2/pokemon-species/149/
/// Example Output: 149
int getLastNumberFromUrl(String url) {
  final List<String> urlParts = url.split('/');
  final String lastPart = urlParts[urlParts.length - 2];
  return int.tryParse(lastPart) ?? -1;
}

String extractRomanNumeral(String input) {
  final List<String> parts = input.split('-');
  if (parts.length == 2) {
    final String romanNumeral = parts[1].toUpperCase();
    return romanNumeral;
  }
  return '';
}
