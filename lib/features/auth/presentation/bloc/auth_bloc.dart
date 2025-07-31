import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/logger/app_logger.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase, this._getCurrentUserUseCase)
    : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Login attempt started', data: {'email': event.email});
    emit(const AuthLoading());

    final result = await _loginUseCase(event.email, event.password);

    result.fold(
      (failure) {
        appLogger.logAuthEvent('Login failed', data: {'error': failure.message});
        emit(AuthFailure(failure.message));
      },
      (user) {
        appLogger.logAuthEvent('Login successful', userId: user.id);
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Logout attempt started');
    emit(const AuthLoading());

    final result = await _logoutUseCase();

    result.fold(
      (failure) {
        appLogger.logAuthEvent('Logout failed', data: {'error': failure.message});
        emit(AuthError(failure.message));
      },
      (_) {
        appLogger.logAuthEvent('Logout successful');
        emit(const AuthUnauthenticated());
      },
    );
  }

  Future<void> _onAuthStatusChecked(AuthStatusChecked event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Auth status check started');
    emit(const AuthLoading());

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) {
        appLogger.logAuthEvent('Auth status check - user not authenticated');
        emit(const AuthUnauthenticated());
      },
      (user) {
        if (user != null) {
          appLogger.logAuthEvent('Auth status check - user authenticated', userId: user.id);
          emit(AuthAuthenticated(user));
        } else {
          appLogger.logAuthEvent('Auth status check - no user found');
          emit(const AuthUnauthenticated());
        }
      },
    );
  }
}
