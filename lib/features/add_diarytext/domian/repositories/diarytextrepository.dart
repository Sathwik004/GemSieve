
import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';


abstract interface class DiaryTextRepository {

Future<Either<Failure,GeminiDiaryText>> fetchdiarytext(String input,String habit);

}