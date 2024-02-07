sealed class Either<L, R> {}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);
}

class Rigth<L, R> extends Either<L, R> {
  final R value;
  Rigth(this.value);
}
