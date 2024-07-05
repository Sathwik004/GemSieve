import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';

abstract interface class STTRepo{
  Future<Either<Failure, void>> init();
  Future<Either<Failure, void>> listen(StreamController<String> recognizedWordsController);
  Future<Either<Failure, void>> stoplistening();
}