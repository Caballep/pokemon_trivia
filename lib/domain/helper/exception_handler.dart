import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/extensions/client_exception_extension.dart';
import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

/// Will log errors and provide a more granulated Error enum identifier that can
/// be used across higher layers. The usage of this class should occur at Repo level.
class ExceptionHandler {
  final Logger _logger;

  ExceptionHandler(this._logger);

  /// Handles all the possible exceptions, logs the error and stack trace, finally
  /// returns a more meaningful [ErrorOutcome] for higher layers.
  Errors handleAndGetError(ExceptionData exceptionData) {
    Errors errorType;

    final e = exceptionData.exception;
    final st = exceptionData.stackTrace;

    if (e is HttpException) {
      errorType = Errors.noInternet;
    }

    if (e is ClientException) {
      final code = e.statusCode!;

      if (code == HttpStatus.notFound || code == HttpStatus.badRequest) {
        errorType = Errors.genericNetwork;
      }

      if (code == HttpStatus.unauthorized ||
          code == HttpStatus.forbidden ||
          code == HttpStatus.internalServerError) {
        errorType = Errors.serverIssue;
      }
    }

    if (e is SocketException) {
      errorType = Errors.genericNetwork;
    }

    if (e is TimeoutException) {
      errorType = Errors.timeOut;
    }

    errorType = Errors.unknown;

    _logger.e('Error dispatched: $errorType', e, st);
    return errorType;
  }
}
