import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/firebase/analytics_service.dart';
import '../../../../core/firebase/crashlytics_service.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AnalyticsService _analyticsService;
  final CrashlyticsService _crashlyticsService;

  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
    this._analyticsService,
    this._crashlyticsService,
  ) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Login attempt started', data: {'email': event.email});
    emit(const AuthLoading());

    try {
      final result = await _loginUseCase(event.email, event.password);

      result.fold(
        (failure) {
          appLogger.logAuthEvent('Login failed', data: {'error': failure.message});
          // Firebase Analytics - login failure
          _analyticsService.logCustomEvent(
            name: 'login_failed',
            parameters: {'error_message': failure.message},
          );
          // Firebase Crashlytics - auth error
          _crashlyticsService.logAuthError(action: 'login', errorMessage: failure.message);
          emit(AuthFailure(failure.message));
        },
        (user) {
          appLogger.logAuthEvent('Login successful', userId: user.id);
          // Firebase Analytics - successful login
          _analyticsService.logLogin(loginMethod: 'email');
          _analyticsService.setUserId(user.id);
          // Firebase Crashlytics - set user info
          _crashlyticsService.setUserInformation(
            userId: user.id,
            email: user.email,
            name: user.name,
          );
          emit(AuthSuccess(user));
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during login',
        fatal: false,
      );
      appLogger.logAuthEvent('Login unexpected error', data: {'error': error.toString()});
      emit(AuthFailure('An unexpected error occurred'));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent(
      'Register attempt started',
      data: {'email': event.email, 'name': event.name},
    );
    emit(const AuthLoading());

    try {
      final result = await _registerUseCase(event.name, event.email, event.password);

      result.fold(
        (failure) {
          appLogger.logAuthEvent('Register failed', data: {'error': failure.message});
          // Firebase Analytics - register failure
          _analyticsService.logCustomEvent(
            name: 'register_failed',
            parameters: {'error_message': failure.message},
          );
          // Firebase Crashlytics - auth error
          _crashlyticsService.logAuthError(action: 'register', errorMessage: failure.message);
          emit(AuthFailure(failure.message));
        },
        (user) {
          appLogger.logAuthEvent('Register successful', userId: user.id);
          // Firebase Analytics - successful register
          _analyticsService.logSignUp(signUpMethod: 'email');
          _analyticsService.setUserId(user.id);
          // Firebase Crashlytics - set user info
          _crashlyticsService.setUserInformation(
            userId: user.id,
            email: user.email,
            name: user.name,
          );
          emit(AuthSuccess(user));
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during registration',
        fatal: false,
      );
      appLogger.logAuthEvent('Register unexpected error', data: {'error': error.toString()});
      emit(AuthFailure('An unexpected error occurred'));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Logout attempt started');
    emit(const AuthLoading());

    try {
      final result = await _logoutUseCase();

      result.fold(
        (failure) {
          appLogger.logAuthEvent('Logout failed', data: {'error': failure.message});
          // Firebase Crashlytics - logout error
          _crashlyticsService.logAuthError(action: 'logout', errorMessage: failure.message);
          emit(AuthError(failure.message));
        },
        (_) {
          appLogger.logAuthEvent('Logout successful');
          // Firebase Analytics - logout
          _analyticsService.logCustomEvent(name: 'logout');
          // Firebase Analytics & Crashlytics - clear user
          _analyticsService.setUserId(null);
          _crashlyticsService.setUserInformation(userId: 'anonymous');
          emit(const AuthUnauthenticated());
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during logout',
        fatal: false,
      );
      appLogger.logAuthEvent('Logout unexpected error', data: {'error': error.toString()});
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onAuthStatusChecked(AuthStatusChecked event, Emitter<AuthState> emit) async {
    appLogger.logAuthEvent('Auth status check started');
    emit(const AuthLoading());

    try {
      final result = await _getCurrentUserUseCase();

      result.fold(
        (failure) {
          appLogger.logAuthEvent('Auth status check - user not authenticated');
          _analyticsService.setUserId(null);
          _crashlyticsService.setUserInformation(userId: 'anonymous');
          emit(const AuthUnauthenticated());
        },
        (user) {
          if (user != null) {
            appLogger.logAuthEvent('Auth status check - user authenticated', userId: user.id);
            // Firebase Analytics & Crashlytics - set user info
            _analyticsService.setUserId(user.id);
            _crashlyticsService.setUserInformation(
              userId: user.id,
              email: user.email,
              name: user.name,
            );
            emit(AuthAuthenticated(user));
          } else {
            appLogger.logAuthEvent('Auth status check - no user found');
            _analyticsService.setUserId(null);
            _crashlyticsService.setUserInformation(userId: 'anonymous');
            emit(const AuthUnauthenticated());
          }
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during auth status check',
        fatal: false,
      );
      appLogger.logAuthEvent(
        'Auth status check unexpected error',
        data: {'error': error.toString()},
      );
      emit(const AuthUnauthenticated());
    }
  }
}
