import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:milkydiary/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkydiary/features/auth/data/repositories/authrepo_imp.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_in.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  await _initAuthdependencies();
}

Future<void> _initAuthdependencies() async {
  serviceLocater.registerLazySingleton(() => GoogleSignIn(),);

  serviceLocater.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: serviceLocater(),),);

  serviceLocater.registerFactory<AuthRepo>(() => AuthRepoImp(authRemoteDataSource: serviceLocater(),),);

  serviceLocater.registerFactory(() => UserSignIn(authRepo: serviceLocater(),),);

  serviceLocater.registerLazySingleton<AuthBloc>(() => AuthBloc(userSignIn: serviceLocater(),),);
}