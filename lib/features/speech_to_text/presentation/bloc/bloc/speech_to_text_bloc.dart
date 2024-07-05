import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/speech_to_text/domain/usecases/stt_init.dart';
import 'package:milkydiary/features/speech_to_text/domain/usecases/stt_listen.dart';
import 'package:milkydiary/features/speech_to_text/domain/usecases/stt_stop.dart';
part 'speech_to_text_event.dart';
part 'speech_to_text_state.dart';

class SpeechToTextBloc extends Bloc<SpeechToTextEvent, SpeechToTextState> {
  final STTInit _sttInit;
  final SttListen _sttListen;
  final SttStop _sttStop;
  
  SpeechToTextBloc(
      {required STTInit sttInit,
      required SttListen sttListen,
      required SttStop sttStop})
      : _sttInit = sttInit,
        _sttListen = sttListen,
        _sttStop = sttStop,
        super(SpeechToTextInitial()) {


    on<SpeechToTextInitialize>(
      (event, emit) async {
        final response = await _sttInit(NoParams());
        print('Hello Hello Hello');

        response.fold(
          (failure) => emit(SpeechToTextError(message: failure.message)),
          (val) => emit(SpeechToTextAvailable(text: 'How was your day?')),
        );
      },
    );

    on<SpeechToTextListen>(
      (event, emit) async {
        String lastEvent = '';
        String lasttext = '';
        Timer? timer;
        Completer<void> completer = Completer<void>();

        
        timer =  Timer.periodic(const Duration(seconds: 2), (timer) {
          if (lastEvent == lasttext && lastEvent.isNotEmpty){
            print('DONNENNENEN');
            timer.cancel();
            emit(SpeechToTextAvailable(text: lastEvent));
            completer.complete();

          }
          else if(lastEvent.isNotEmpty){
            lasttext = lastEvent;
              emit(SpeechToTextListening(text: lastEvent),);

          }
        });


        final StreamController<String> controller = StreamController<String>();

        controller.stream.listen((event) {
          //(state as SpeechToTextListening).text = event;
          lastEvent = event;
        });
        await _sttListen(Params(recognizedWordsController: controller));
        await completer.future;
        
      },
    );

    on<SpeechToTextStop>(
      (event, emit) async{
        await _sttStop(NoParams());
        var text = 'available';
        if(state is SpeechToTextListening){
          text = (state as SpeechToTextListening).text;
        }
        emit(SpeechToTextAvailable(text: text),);
      },
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //controller.close();
    return super.close();
  }
}
