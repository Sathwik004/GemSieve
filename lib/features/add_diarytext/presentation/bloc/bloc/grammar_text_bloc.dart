import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/add_diarytext/domian/usecase/correctgrammer_usecase.dart';

part 'grammar_text_event.dart';
part 'grammar_text_state.dart';

class GrammarTextBloc extends Bloc<GrammarTextEvent, GrammarTextState> {
  final CorrectGrammerUsecase _grammerusecase;
  GrammarTextBloc({required CorrectGrammerUsecase grammerusecase}) :_grammerusecase=grammerusecase, super(GrammarTextInitial()) {
    
    // on<GrammarTextEvent>((event, emit) 
    // {
    //  emit(GrammarTextInitial());
    // });
    on<FetchGrammerEvent>((event, emit) async{
     emit(GrammarTextLoading());
     final response=await _grammerusecase.call(GrammerParam(input: event.input));
      response.fold(
          (l) {
            emit(GrammarTextFailure());
          },
          (r) {
            emit(GrammarTextSuccess(r));
          },
      );
    });
  }
}
