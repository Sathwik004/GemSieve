import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

abstract interface class STTRemoteDataSource {
  Future<void> init();
  Future<void> listen(StreamController<String> recognizedWordsController);
  Future<void> stoplistening();
}

class STTRemoteDataSourceImpl implements STTRemoteDataSource {
  final SpeechToText speechToText;


  STTRemoteDataSourceImpl({required this.speechToText});

  @override
  Future<void> init() async {
    await speechToText.initialize(
      onError: (val) => print(val),
      onStatus: (val) => print('$val STATUS'),
    );
  }

  @override
  Future<void> listen(StreamController<String> recognizedWordsController) async{
    
    print('inside');
    await speechToText.listen(
      onResult: (val) {
        print('onResultt');
        print(val.recognizedWords);
        recognizedWordsController.add(val.recognizedWords);
      }
    );
  }

  @override
  Future<void> stoplistening() async {
    await speechToText.stop();
  }
}

