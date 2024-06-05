// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/add_diarytext.dart/domian/repositories/correctgrammer_repository.dart';

class CorrectGrammerUsecase implements UseCase<String,GrammerParam>{
  final GrammerTextRepository grammerrepo;
  CorrectGrammerUsecase(this.grammerrepo);
  @override
  Future<Either<Failure, String>> call(GrammerParam params) async{
    return await grammerrepo.fetchcorrectgrammer(params.input);
  }

}

class GrammerParam {
  final String input;
  GrammerParam({
    required this.input,
  });
}
