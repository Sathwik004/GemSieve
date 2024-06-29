import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextWidget extends StatefulWidget {
  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _speechEnabled = false;
  String _text = 'Listening...';
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
            _text = val.recognizedWords;
            _isListening = _speech.isListening;
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
          child: Text( _speechEnabled ? _text : 'Speech recognition unavailable',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        glowRadiusFactor: 1.0,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        startDelay: const Duration(milliseconds: 1000),
        child: FloatingActionButton(
          onPressed: _speech.isNotListening ? _listen : _stopListening,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
}
