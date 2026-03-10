import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final Object? user;

  const AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}

class GoogleSignInRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class PhoneAuthRequested extends AuthEvent {
  final String phoneNumber;

  const PhoneAuthRequested({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class OtpSubmitted extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const OtpSubmitted({required this.verificationId, required this.smsCode});

  @override
  List<Object?> get props => [verificationId, smsCode];
}
