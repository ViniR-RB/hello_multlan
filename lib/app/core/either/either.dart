sealed class Either<S, E extends Exception> {}

sealed class Failure<S, E extends Exception> {
  final E exception;
  Failure(this.exception);
}

sealed class Sucess<S, E extends Exception> {
  final S value;
  Sucess(this.value);
}
