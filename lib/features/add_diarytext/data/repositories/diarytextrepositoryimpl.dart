import 'package:fpdart/src/either.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/exceptions/server_exception.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/diary_data_source.dart';
import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/diarytextrepository.dart';

class DiaryTextRepositoryImpl implements DiaryTextRepository {
  final DiaryDataSource datasource;
  DiaryTextRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, GeminiDiaryText>> fetchdiarytext(
      String input, String habit) async {
    try {
      final response = await datasource.fetchdiary(input, habit);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
