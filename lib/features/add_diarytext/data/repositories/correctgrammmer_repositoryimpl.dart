// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/exceptions/server_exception.dart';
import 'package:milkydiary/features/add_diarytext/data/datasources/correctgrammar_data_source.dart';
import 'package:milkydiary/features/add_diarytext/domian/repositories/correctgrammer_repository.dart';

class CorrectgrammmerRepositoryimpl implements GrammerTextRepository {
final Grammartextdatasource grammersource;
  CorrectgrammmerRepositoryimpl(
   this.grammersource,
  );

  @override
  Future<Either<Failure, String>> fetchcorrectgrammer(String input) async {
    try{
           final response=await grammersource.fetchgrammar(input);
           return right(response.correntedtext);
    } on ServerException catch (e){
      return left(Failure(e.message));
    }
  }

}
