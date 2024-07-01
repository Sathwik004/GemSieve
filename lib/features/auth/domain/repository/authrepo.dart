import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, String>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
}

