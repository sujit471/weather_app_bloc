import'package:flutter_bloc/flutter_bloc.dart';
abstract class AuthenticationEvent {
   const AuthenticationEvent();
   List<Object> get props => [];
}
class SignUpuser  extends AuthenticationEvent{
  final String email ;
  final  String password;
  const SignUpuser (this.email,this.password);
  @override
  List<Object> get props =>[email,password];
}
class SignOut extends AuthenticationEvent{}