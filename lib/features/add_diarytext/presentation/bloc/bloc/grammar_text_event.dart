part of 'grammar_text_bloc.dart';

@immutable
sealed class GrammarTextEvent {
//  final String input;
}

final class FetchGrammerEvent extends GrammarTextEvent{
  final String input;
  FetchGrammerEvent(this.input);
}