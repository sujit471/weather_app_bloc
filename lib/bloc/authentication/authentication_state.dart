import 'package:equatable/equatable.dart';
import '../../services/user_model.dart';

// Define Authentication States
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  const AuthenticationLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;

  const AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
