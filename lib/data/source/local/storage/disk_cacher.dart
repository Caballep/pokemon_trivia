import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/* This class provides necssary functionality to store images in the disk
 * memory of the device. It won't work on web.
 */
class DiskCacher {
  Future<File> downloadAndSaveImage(String imageUrl, String fileName) async {
    final response = await http.get(Uri.parse(imageUrl));
    final appDir = await getApplicationDocumentsDirectory();
    final file = File('${appDir.path}/$fileName.png');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future<File> getImageFileFromPokemonName(String pokemonName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File('${appDir.path}/$pokemonName.png');
    return file;
  }
}
