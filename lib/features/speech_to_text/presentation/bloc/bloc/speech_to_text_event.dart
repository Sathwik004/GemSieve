part of 'speech_to_text_bloc.dart';

abstract class SpeechToTextEvent {}

class SpeechToTextInitialize extends SpeechToTextEvent {}

class SpeechToTextListen extends SpeechToTextEvent {}

class SpeechToTextStop extends SpeechToTextEvent {}
