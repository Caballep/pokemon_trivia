import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/extensions/client_exception_extension.dart';
import 'package:pokemon_trivia/core/propagation/error.dart';

/// Will log errors and provide a more granulated Error enum identifier that can
/// be used across higher layers. The usage of this class should occur at Repo level.
class ExceptionHandler {
  final Logger _logger;

  ExceptionHandler(this._logger);

  /// Handles all the possible exceptions, logs the error and stack trace, finally
  /// returns a more meaningful [Error] for higher layers.
  Error handleExceptionAndGetError(Exception e, StackTrace stackTrace) {
    Error error;

    if (e is HttpException) {
      error = Error.noInternet;
    }

    if (e is ClientException) {
      final code = e.statusCode!;

      if (code == HttpStatus.notFound || code == HttpStatus.badRequest) {
        error = Error.genericNetwork;
      }

      if (code == HttpStatus.unauthorized ||
          code == HttpStatus.forbidden ||
          code == HttpStatus.internalServerError) {
        error = Error.serverIssue;
      }
    }

    if (e is SocketException) {
      error = Error.genericNetwork;
    }

    if (e is TimeoutException) {
      error = Error.timeOut;
    }

    error = Error.unknown;

    _logger.e('Error dispatched: $error', e, stackTrace);
    return error;
  }
}
