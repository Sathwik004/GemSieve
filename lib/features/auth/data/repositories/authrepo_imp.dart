import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/exceptions/server_exception.dart';
import 'package:milkydiary/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImp implements AuthRepo{

  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImp({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    try{
      final userId = await authRemoteDataSource.signInWithGoogle();

      return right(userId);
    }
    on ServerException catch(e){
      return left(Failure(e.message));
    }
    catch(e){
      return left(Failure(e.toString()));
      
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try{
      await authRemoteDataSource.signOut();
      return right(null);
    }
    on ServerException catch(e){
      return left(Failure(e.message));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }
  
}