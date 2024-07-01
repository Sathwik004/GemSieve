import 'package:flutter/material.dart';
import 'package:milkydiary/features/speech_to_text/presentation/widgets/speech_to_text_mic_button.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextWidget extends StatefulWidget {

  const SpeechToTextWidget({super.key});

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  late stt.SpeechToText _speech;
  bool isListening = false;
  bool _speechEnabled = false;
  String text = 'Listening...';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async{
    _speechEnabled = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),

      );
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

  void _listen() async{
      
      
        await _speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            isListening = _speech.isListening;
            if (val.hasConfidenceRating && val.confidence > 0)
            {
              _confidence = val.confidence;
            }
          },),
        );
      
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text ${_confidence.toStringAsFixed(2)}'),
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Text( _speechEnabled ? text : 'Speech recognition unavailable',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: STTMicButton(isListening: isListening, listen: _listen, stoplistening: _stopListening,)
    );
  }
}


