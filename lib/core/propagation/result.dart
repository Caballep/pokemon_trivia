import 'package:pokemon_trivia/core/propagation/error.dart';

class Result<T> {
  final T? data;
  final RepoError? error;

  Result._(this.data, this.error);

  factory Result.success(T data) {
    return Result._(data, null);
  }

  factory Result.error(RepoError error) {
    return Result._(null, error);
  }

  bool get isSuccess => error == null;
  bool get isError => error != null;
}
