part of 'speech_to_text_bloc.dart';

abstract class SpeechToTextState {}

final class SpeechToTextInitial extends SpeechToTextState {}

final class SpeechToTextListening extends SpeechToTextState {
  String text;
  SpeechToTextListening({required this.text});
}

final class SpeechToTextAvailable extends SpeechToTextState {
  String text;
  SpeechToTextAvailable({required this.text});
}

final class SpeechToTextError extends SpeechToTextState {
  String message;
  SpeechToTextError({required this.message});
}
