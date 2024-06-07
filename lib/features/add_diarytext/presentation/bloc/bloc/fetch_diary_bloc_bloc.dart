import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/fetchdiary_usecase.dart';
part 'fetch_diary_bloc_event.dart';
part 'fetch_diary_bloc_state.dart';

class FetchDiaryBloc
    extends Bloc<FetchDiaryBlocEvent, FetchDiaryBlocState> {
  final FetchDiaryUsecase _fetchdiary;
  FetchDiaryBloc({required fetchdiary})
      : _fetchdiary = fetchdiary,
        super(FetchDiaryBlocInitial()) {
    on<FetchDiaryWithHabits>(
      (event, emit) async {
        emit(FetchDiaryLoading());

        final response = await _fetchdiary.call(
            GetDiaryTextParams(input: event.input, myhabits: event.habits));
        response.fold(
          (l) {
            emit(FetchDiaryFailure(l.message));
          },
          (r) {
            emit(FetchDiarySuccess(r));
          },
        );
      },
    );
  }
}
