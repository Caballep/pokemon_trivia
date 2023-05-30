import 'dart:io';
import 'package:http/http.dart' as http;

extension ClientExceptionExtension on http.ClientException {
  /// Provides status code within the exception. Can be compared with [HttpStatus].
  int? get statusCode {
    final statusCodeMatch = RegExp(r'\b\d{3}\b').firstMatch(message);
    final statusCode = statusCodeMatch?.group(0);
    return statusCode != null ? int.tryParse(statusCode) : null;
  }
}
