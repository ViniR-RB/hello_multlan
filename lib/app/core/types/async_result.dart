import 'package:hellomultlan/app/core/either/either.dart';

typedef AsyncResult<R, L extends Exception> = Future<Either<R, L>>;
