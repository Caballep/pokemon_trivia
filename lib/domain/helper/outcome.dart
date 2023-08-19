abstract class Outcome<T> {}

class SuccessOutcome<T> extends Outcome<T> {
  final T data;

  SuccessOutcome(this.data);
}

class ErrorOutcome extends Outcome<Null> {
  final Errors error;

  ErrorOutcome(this.error);
}

enum Errors {
  // Network:
  genericNetwork,
  noInternet,
  serverIssue,
  timeOut,

  // Local Storage:

  // Others:
  unknown,
  nullOrEmptyUnexpectedData,

  // Flow
  nullItem,
  errorInItem
}
