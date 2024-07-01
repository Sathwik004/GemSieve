part of 'grammar_text_bloc.dart';

abstract class GrammarTextEvent {
//  final String input;
}

final class FetchGrammerEvent extends GrammarTextEvent{
  final String input;
  FetchGrammerEvent(this.input);
}