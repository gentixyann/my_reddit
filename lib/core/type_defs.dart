import 'package:fpdart/fpdart.dart';
import 'package:my_reddit/core/failure.dart';

// Either型とは抽象クラスで、正常時用にEither型を継承したRight型が、
// 例外時用に同じくEither型を継承したLeft型がそれぞれ用意されています。
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
