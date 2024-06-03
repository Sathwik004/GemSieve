import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);

}

class NoParams {} // Use this class if you don't want to pass any params to the usecase