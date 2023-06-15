List<int> getOrderedPokemonNumbersFromUrls(List<String> pokemonsUrls) {
  final List<int> pokemonNumbers = pokemonsUrls.map((url) {
    final List<String> urlParts = url.split('/');
    final String numberPart = urlParts[urlParts.length - 2];
    return int.tryParse(numberPart) ?? -1;
  }).toList();

  pokemonNumbers.sort();
  return pokemonNumbers;
}
