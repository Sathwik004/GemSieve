// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/diarytextrepository.dart';

class FetchDiaryUsecase implements UseCase<GeminiDiaryText,GetDiaryTextParams>{
final DiaryTextRepository repo;
FetchDiaryUsecase(this.repo);

  @override
  Future<Either<Failure, GeminiDiaryText>> call(GetDiaryTextParams params) async {
    return await repo.fetchdiarytext(params.input, params.myhabits);
  }

}

class GetDiaryTextParams {
final String input;
final String myhabits;
  GetDiaryTextParams({
    required this.input,
    required this.myhabits,
  });
}
