// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final RegisterFormModel data;
  const RegisterEvent({
    required this.data,
  });
}

class LoginEvent extends AuthEvent {
  final LoginFormModel data;
  const LoginEvent({
    required this.data,
  });
}

class LogoutEvent extends AuthEvent {
  final String token;
  const LogoutEvent({
    required this.token,
  });
}

class GetCurrentUser extends AuthEvent {}
