import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/correctgrammar_data_source.dart';
import 'package:milkydiary/features/add_diarytext/data/repositories/correctgrammmer_repositoryimpl.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/correctgrammer_repository.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/correctgrammer_usecase.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/firebase_bloc.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/grammar_text_bloc.dart';
import 'package:milkydiary/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkydiary/features/auth/data/repositories/authrepo_imp.dart';
import 'package:milkydiary/features/auth/domain/repository/authrepo.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_in.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_out.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/diary_data_source.dart';
import 'package:milkydiary/features/add_diarytext/data/repositories/diarytextrepositoryimpl.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/diarytextrepository.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/fetchdiary_usecase.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  await _initAuthdependencies();
  await _fetchDiary();
 await _fetchgrammar();
 await _firestore();
}

Future<void> _initAuthdependencies() async {
  serviceLocater.registerLazySingleton(() => GoogleSignIn(),);

  serviceLocater.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: serviceLocater(),),);

  serviceLocater.registerFactory<AuthRepo>(() => AuthRepoImp(authRemoteDataSource: serviceLocater(),),);

  serviceLocater.registerFactory(() => UserSignIn(authRepo: serviceLocater(),),);

  serviceLocater.registerFactory(() => UserSignOut(authRepo: serviceLocater(),),);

  serviceLocater.registerLazySingleton<AuthBloc>(() => AuthBloc(userSignIn: serviceLocater(), userSignOut: serviceLocater()),);
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

  serviceLocater.registerFactory(
    () => FetchDiaryUsecase(
      serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton<FetchDiaryBloc>(
    () => FetchDiaryBloc(
      fetchdiary: serviceLocater(),
    ),
  );
}

Future<void> _fetchgrammar() async
{
serviceLocater.registerFactory<Grammartextdatasource>(
  () => GrammerTextdatasourceimpl(),
);

serviceLocater.registerFactory<GrammerTextRepository>(
  () => CorrectgrammmerRepositoryimpl(serviceLocater()),
);

serviceLocater.registerFactory(
  () => CorrectGrammerUsecase(serviceLocater()),
);

serviceLocater.registerLazySingleton<GrammarTextBloc>(
() => GrammarTextBloc(grammerusecase: serviceLocater()),
);
}

Future<void> _firestore() async{
  serviceLocater.registerLazySingleton<FirebaseBloc>(
    () => FirebaseBloc(),
  );
}