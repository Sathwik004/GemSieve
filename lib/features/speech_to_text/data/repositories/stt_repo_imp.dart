import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/exceptions/server_exception.dart';
import 'package:milkydiary/features/speech_to_text/data/datasources/stt_remote_data_source.dart';
import 'package:milkydiary/features/speech_to_text/domain/repository/stt_repo.dart';

class STTRepoImp implements STTRepo{
  final STTRemoteDataSource sttRemoteDataSource;

  const STTRepoImp({required this.sttRemoteDataSource});
  @override
  Future<Either<Failure, void>> init() async {
    try{
      await sttRemoteDataSource.init();
      return right(null);
    }
    on ServerException catch(e){
      return left(Failure(e.message));

    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> listen(StreamController<String> recognizedWordsController) async{
    try {
      await sttRemoteDataSource.listen(recognizedWordsController);
      return right(null);
    }
    on ServerException catch(e) {
      return left(Failure(e.message));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> stoplistening() async{
    try{
      await sttRemoteDataSource.stoplistening();
      return right(null);
    }
    on ServerException catch(e){
      return left(Failure(e.message));
    }
    catch(e){
      return left(Failure(e.toString()));
    }
  }
  
}