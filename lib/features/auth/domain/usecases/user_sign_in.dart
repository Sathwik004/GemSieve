
import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';

class UserSignIn implements UseCase<String, NoParams> {
  final AuthRepo authRepo;

  UserSignIn({required this.authRepo});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepo.signInWithGoogle();
  }
}