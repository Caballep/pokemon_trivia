class Result<T> {
  final T? data;
  final ExceptionData? exceptionData;

  Result._(this.data, this.exceptionData);

  factory Result.success(T data) {
    return Result._(data, null);
  }

  factory Result.error(ExceptionData exceptionData) {
    return Result._(null, exceptionData);
  }

  bool get isSuccess => exceptionData == null;
  bool get isError => exceptionData != null;
}

class ExceptionData {
  final Exception exception;
  final StackTrace stackTrace;

  ExceptionData(this.exception, this.stackTrace);
}
