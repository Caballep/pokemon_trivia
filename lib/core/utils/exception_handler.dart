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
  /// returns a more meaningful [RepoError] for higher layers.
  RepoError handleExceptionAndGetError(Exception e, StackTrace stackTrace) {
    RepoError error;

    if (e is HttpException) {
      error = RepoError.noInternet;
    }

    if (e is ClientException) {
      final code = e.statusCode!;

      if (code == HttpStatus.notFound || code == HttpStatus.badRequest) {
        error = RepoError.genericNetwork;
      }

      if (code == HttpStatus.unauthorized ||
          code == HttpStatus.forbidden ||
          code == HttpStatus.internalServerError) {
        error = RepoError.serverIssue;
      }
    }

    if (e is SocketException) {
      error = RepoError.genericNetwork;
    }

    if (e is TimeoutException) {
      error = RepoError.timeOut;
    }

    error = RepoError.unknown;

    _logger.e('Error dispatched: $error', e, stackTrace);
    return error;
  }
}
