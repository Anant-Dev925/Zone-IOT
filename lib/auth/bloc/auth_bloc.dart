import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/auth/bloc/auth_event.dart';
import 'package:iot/auth/bloc/auth_state.dart';
import 'package:iot/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    // SIGN UP → send OTP
    on<SignUpSubmitted>((event, emit) async {
      emit(AuthLoading());
      final result = await repository.signUp(
        event.name,
        event.surname,
        event.address,
        event.email,
        event.phone,
      );

      if (result.$1) {
        emit(OtpSent());
      } else {
        emit(AuthError(result.$2));
      }
    });

    // SIGN IN → send OTP
    on<SignInSubmitted>((event, emit) async {
      emit(AuthLoading());
      final result = await repository.signIn(event.email, event.phone);

      if (result.$1) {
        emit(OtpSent());
      } else {
        emit(AuthError(result.$2));
      }
    });

    // VERIFY OTP → returns user data or error
    on<VerifyOtp>((event, emit) async {
      emit(AuthLoading());
      final result = await repository.verifyOtp(
        event.email,
        event.phone,
        event.otp,
      );

      if (result.$1) {
        emit(AuthSuccess(result.$3));
      } else {
        emit(AuthError(result.$2));
      }
    });

    // RESET
    on<ResetAuth>((event, emit) {
      emit(AuthInitial());
    });
  }
}
