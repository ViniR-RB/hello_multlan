sealed class Either<S, E extends Exception> {}

final class Failure<S, E extends Exception> extends Either<S, E> {
  final E exception;
  Failure(this.exception);

  Object? get GatewayException => null;
}

final class Sucess<S, E extends Exception> extends Either<S, E> {
  final S value;
  Sucess(this.value);
}
