part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent {}

final class AuthSignIn extends AuthBlocEvent {}

final class AuthChanges extends AuthBlocEvent {}