part of 'grammar_text_bloc.dart';

abstract class GrammarTextState {}

final class GrammarTextInitial extends GrammarTextState {}
final class GrammarTextLoading extends GrammarTextState{}
final class GrammarTextSuccess extends GrammarTextState{
  final String grammertext;
   GrammarTextSuccess(this.grammertext);
}
final class GrammarTextFailure extends GrammarTextState{}