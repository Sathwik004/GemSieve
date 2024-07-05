import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/speech_to_text/domain/repository/stt_repo.dart';

class SttListen implements UseCase<void, Params> {
  final STTRepo sttRepo;

  const SttListen({required this.sttRepo});

  @override
  Future<Either<Failure,void>> call(Params params) async {
    return await sttRepo.listen(params.recognizedWordsController);
  }}

class Params{
  final StreamController<String> recognizedWordsController;
  const Params({required this.recognizedWordsController});
}