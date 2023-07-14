part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnAuthenthicated extends AuthState {}

class Authenthicated extends AuthState {
  final UserModel user;
  const Authenthicated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({required this.message});

  @override
  List<Object> get props => [message];
}
