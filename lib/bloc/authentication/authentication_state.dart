sealed class AuthenticationState {
  const AuthenticationState();
  List<Object> get props =>[];
}
class AuthenticationInitial extends AuthenticationState{}
class AutheticationLoadingState extends AuthenticationState{
  final bool isLoading;
  AutheticationLoadingState(this.isLoading);
}
class AuthenticationSuccess extends AuthenticationState{

}
class AuthenticationError extends AuthenticationState{
  final String message;
   const AuthenticationError(this.message);
  @override
  List <Object> get props => [];
}
