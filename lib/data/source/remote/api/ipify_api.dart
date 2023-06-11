import 'package:http/http.dart' as http;

class IpifyApi {
  final _baseUrl = 'https://api.ipify.org';

  Future<String> getIP() async {
    try {
      // Make a request to a public API to retrieve the IP address
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      // Handle error if unable to retrieve the IP address
    }

    // Return a default IP address if retrieval fails
    return '127.0.0.1'; // Placeholder IP address
  }
}
