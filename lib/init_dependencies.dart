import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:milkydiary/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkydiary/features/auth/data/repositories/authrepo_imp.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_in.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/diary_data_source.dart';
import 'package:milkydiary/features/add_diarytext/data/repositories/diarytextrepositoryimpl.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/diarytextrepository.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/fetchdiary_usecase.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  await _initAuthdependencies();
  await _fetchDiary();
}

Future<void> _initAuthdependencies() async {
  serviceLocater.registerLazySingleton(() => GoogleSignIn(),);

  serviceLocater.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: serviceLocater(),),);

  serviceLocater.registerFactory<AuthRepo>(() => AuthRepoImp(authRemoteDataSource: serviceLocater(),),);

  serviceLocater.registerFactory(() => UserSignIn(authRepo: serviceLocater(),),);

  serviceLocater.registerLazySingleton<AuthBloc>(() => AuthBloc(userSignIn: serviceLocater(),),);
}

Future<void> _fetchDiary() async {
  serviceLocater.registerFactory<DiaryDataSource>(
    () => DiaryDataSourceImpl(),
  );

  serviceLocater.registerFactory<DiaryTextRepository>(
    () => DiaryTextRepositoryImpl(
      serviceLocater(),
    ),
  );

  serviceLocater.registerFactory<UseCase>(
    () => FetchDiaryUsecase(
      serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton(
    () => FetchDiaryBloc(
      fetchdiary: serviceLocater(),
    ),
  );
}
