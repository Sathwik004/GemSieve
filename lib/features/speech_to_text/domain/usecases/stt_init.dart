import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/speech_to_text/domain/repository/stt_repo.dart';

class STTInit implements UseCase<void, NoParams> {
  final STTRepo sttRepo;

  const STTInit({required this.sttRepo});

  @override
  Future<Either<Failure,void>> call(NoParams params) async{
    return await sttRepo.init();
  }
}