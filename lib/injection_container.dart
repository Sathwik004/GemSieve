import 'package:get_it/get_it.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/diary_data_source.dart';
import 'package:milkydiary/features/add_diarytext/data/repositories/diarytextrepositoryimpl.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/diarytextrepository.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/fetchdiary_usecase.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';

final sl = GetIt.instance;

Future<void> initdependencies() async {
  _fetchDiary();
}

void _fetchDiary() {
  sl.registerFactory<DiaryDataSource>(
    () => DiaryDataSourceImpl(),
  );

  sl.registerFactory<DiaryTextRepository>(
    () => DiaryTextRepositoryImpl(
      sl(),
    ),
  );

  sl.registerFactory<UseCase>(
    () => FetchDiaryUsecase(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FetchDiaryBloc(
      fetchdiary: sl(),
    ),
  );
}
