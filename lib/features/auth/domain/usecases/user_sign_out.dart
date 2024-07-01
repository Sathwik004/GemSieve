
import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  UserSignOut({required this.authRepo});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepo.signOut();
  }
}

