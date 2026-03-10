import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/services/firebase_auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required FirebaseAuthService authService})
    : _authService = authService,
      super(AuthInitial()) {
    on<AuthUserChanged>(_onUserChanged);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PhoneAuthRequested>(_onPhoneAuthRequested);
    on<OtpSubmitted>(_onOtpSubmitted);

    _userSubscription = _authService.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // Emit Authenticated directly so we don't rely on stream race
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_friendlyError(e.code)));
    } catch (e) {
      emit(AuthError(_friendlyError(e.toString())));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Registration failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_friendlyError(e.code)));
    } catch (e) {
      emit(AuthError(_friendlyError(e.toString())));
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        // User cancelled — go back to unauthenticated
        emit(Unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_friendlyError(e.code)));
    } catch (e) {
      emit(AuthError(_friendlyError(e.toString())));
    }
  }

  Future<void> _onPhoneAuthRequested(
    PhoneAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final completer = Completer<void>();

    try {
      await _authService.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        onCodeSent: (verificationId, resendToken) {
          emit(OtpSent(verificationId));
          completer.complete();
        },
        onVerificationFailed: (e) {
          emit(AuthError(_friendlyError(e.code)));
          completer.complete();
        },
        onVerificationCompleted: (credential) async {
          // Auto-verification (rare on iOS, common on Android)
          // We don't necessarily want to emit Authenticated here if we're mid-stream,
          // let the auth state listener handle it or manually sign in.
        },
        onCodeAutoRetrievalTimeout: () {
          // Optional: handle timeout
        },
      );
      await completer.future;
    } catch (e) {
      emit(AuthError(_friendlyError(e.toString())));
    }
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithPhoneCredential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('OTP verification failed.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_friendlyError(e.code)));
    } catch (e) {
      emit(AuthError(_friendlyError(e.toString())));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Convert Firebase error codes to user-friendly messages
  static String _friendlyError(String input) {
    final code = input.toLowerCase();
    if (code.contains('user-not-found')) {
      return 'No account found with this email. Please register first.';
    } else if (code.contains('wrong-password') ||
        code.contains('invalid-credential')) {
      return 'Incorrect password. Please try again.';
    } else if (code.contains('email-already-in-use')) {
      return 'This email is already registered. Please login instead.';
    } else if (code.contains('weak-password')) {
      return 'Password is too weak. Use at least 6 characters.';
    } else if (code.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (code.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    } else if (code.contains('network-request-failed')) {
      return 'No internet connection. Please check your network.';
    }
    return input;
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
