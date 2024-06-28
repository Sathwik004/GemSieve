import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/core/usecase/usecase.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_in.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  final UserSignIn _userSignIn;
  AuthBloc({required UserSignIn userSignIn})
      : _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoadingState());
      final response = await _userSignIn(NoParams());

      response.fold(
          (failure) => emit(AuthFailureState(message: failure.message)),
          (uid) => emit(AuthSuccessState(userId: uid)));
    });
    on<AuthChanges>((event, emit) async {
      //if user logs out emit AuthInitial state
    });
  }
}
