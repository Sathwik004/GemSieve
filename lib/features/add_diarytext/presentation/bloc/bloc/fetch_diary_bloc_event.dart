part of 'fetch_diary_bloc_bloc.dart';

@immutable
sealed class FetchDiaryBlocEvent {}
class FetchDiaryWithInitialEvent extends FetchDiaryBlocEvent{}
class FetchDiaryWithHabits extends FetchDiaryBlocEvent{
  final String input;
  final String habits;
  FetchDiaryWithHabits(this.input,this.habits);
}