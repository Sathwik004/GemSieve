part of 'fetch_diary_bloc_bloc.dart';

@immutable
sealed class FetchDiaryBlocState {}

final class FetchDiaryBlocInitial extends FetchDiaryBlocState {}

class FetchDiaryLoading extends FetchDiaryBlocState{}

class FetchDiarySuccess extends FetchDiaryBlocState{
  final GeminiDiaryText output;
  FetchDiarySuccess(this.output);
}

class FetchDiaryFailure extends FetchDiaryBlocState{
  final String message;
  FetchDiaryFailure(this.message);
}