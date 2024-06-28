import 'package:fpdart/fpdart.dart';
import 'package:milkydiary/core/error/failure.dart';

abstract interface class GrammerTextRepository{
Future<Either<Failure,String>> fetchcorrectgrammer(String input);
}