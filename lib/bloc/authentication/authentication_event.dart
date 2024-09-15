import 'package:equatable/equatable.dart';
import 'package:weather_app_bloc/bloc/authentication/authentication_state.dart';

// Define Authentication Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Event for signing up a user
class SignUpUser extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
class SigninUser extends AuthenticationEvent {
  final String email;
  final String password;

  SigninUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
// Event for signing out a user
class SignOut extends AuthenticationEvent {}

class SignInWithGoogle extends AuthenticationEvent{}