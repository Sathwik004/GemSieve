import 'package:flutter_bloc/flutter_bloc.dart';
part 'speech_to_text_event.dart';
part 'speech_to_text_state.dart';

class SpeechToTextBloc extends Bloc<SpeechToTextEvent, SpeechToTextState> {
  SpeechToTextBloc() : super(SpeechToTextInitial()) {
    on<SpeechToTextEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
