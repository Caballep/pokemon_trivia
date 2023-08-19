import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_trivia/core/extensions/client_exception_extension.dart';
import 'package:pokemon_trivia/data/util/result.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';

class ResultHandler {
  final Logger _logger;

  ResultHandler(this._logger);

  Errors? handle(Result<dynamic> result, {bool errorWhenNull = false}) {
    if (result.exceptionData != null) {
      Errors error;
      final exceptionData = result.exceptionData!;

      final e = exceptionData.exception;
      final st = exceptionData.stackTrace;

      if (e is HttpException) {
        error = Errors.noInternet;
      }

      if (e is ClientException) {
        if (e.statusCode == null) {
          return Errors.noInternet;
        }

        final code = e.statusCode!;

        if (code == HttpStatus.notFound || code == HttpStatus.badRequest) {
          error = Errors.genericNetwork;
        }

        if (code == HttpStatus.unauthorized ||
            code == HttpStatus.forbidden ||
            code == HttpStatus.internalServerError) {
          error = Errors.serverIssue;
        }
      }

      if (e is SocketException) {
        error = Errors.genericNetwork;
      }

      if (e is TimeoutException) {
        error = Errors.timeOut;
      }

      error = Errors.unknown;

      _logger.e('Error dispatched: $error', e, st);

      return error;
    }

    // If the previous block didn't execute, it means there is no error, for instance
    // we check if a null is expected within the result data, if not and data is null
    // then something went wrong.
    if (errorWhenNull && result.data == null) {
      return Errors.nullOrEmptyUnexpectedData;
    }

    return null;
  }
}
