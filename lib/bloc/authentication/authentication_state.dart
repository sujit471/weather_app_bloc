import 'package:equatable/equatable.dart';
import '../../services/user_model.dart';

// // Define Authentication States
// abstract class AuthenticationState extends Equatable {
//   const AuthenticationState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class AuthenticationInitial extends AuthenticationState {}
//
// class AuthenticationLoadingState extends AuthenticationState {
//   final bool isLoading;
//
//   const AuthenticationLoadingState({required this.isLoading});
//
//   @override
//   List<Object> get props => [isLoading];
// }
//
// class AuthenticationSuccess extends AuthenticationState {
//   final UserModel user;
//
//   const AuthenticationSuccess(this.user);
//
//   @override
//   List<Object> get props => [user];
// }
//
// class AuthenticationError extends AuthenticationState {
//   final String message;
//
//   const AuthenticationError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class SignUpSuccess extends AuthenticationState{
// final UserModel user ;
// const SignUpSuccess(this.user);
// }

enum AuthStatus {
  initial ,
  isLoading ,
  success ,
  error ,
  signUpSuccess ,

}
class AuthenticationState extends Equatable {
  final UserModel ?  user  ;
  final AuthStatus status ;
  final String ? message ;
  const AuthenticationState  (
      {
        required this.status,
        this.user,
        this.message,
      });
  // factory  AuthenticationState._(
  //     {
  //       required AuthStatus status,
  //       UserModel ?  user ,
  //     }
  //     )
  // {return AuthenticationState (
  //     status : status ,
  //     user : user,
  // );
  // }
  AuthenticationState copyWith(
      {
        AuthStatus ? status ,
        UserModel ? user ,
      }
      )
  {
    return  AuthenticationState (status : status ?? this.status , user : user ?? this.user );
  }


  @override
  List<Object?> get props => [status, user];
  @override
  String toString (){
    return 'AuthenticationState {status : $status , user : $user}';
  }





}
