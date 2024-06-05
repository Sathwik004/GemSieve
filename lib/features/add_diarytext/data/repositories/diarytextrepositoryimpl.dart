import 'package:fpdart/src/either.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/features/add_diarytext.dart/domian/entities/geminidiarytext.dart';
import 'package:milkydiary/features/add_diarytext.dart/domian/repositories/diarytextrepository.dart';

class DiaryTextRepositoryImpl implements DiaryTextRepository{
  
  @override
  Future<Either<Failure, GeminiDiaryText>> fetchdiarytext(String input, String habit) {
   
  }

}