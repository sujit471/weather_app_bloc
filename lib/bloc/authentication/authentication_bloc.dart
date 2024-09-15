import 'package:bloc/bloc.dart';
import '../../services/authentication.dart';
import '../../services/user_model.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;
  AuthenticationBloc({required this.authService}) : super(const AuthenticationState(status : AuthStatus.initial)) {
    // AuthenticationBloc({required this.authService : super(AuthenticationInitial()})
    on<SigninUser>((event, emit) async {
      emit(const AuthenticationState(status: AuthStatus.isLoading));
     // emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signInUser(event.email, event.password);
        if (user != null) {
          print('User signed in successfully');
          emit(AuthenticationState(status: AuthStatus.success , user: user));
         // emit(AuthenticationSuccess(user));
        } else {
          print('Failed to authenticate user');
          emit(const AuthenticationState(message: 'Failed to authenticate user1',status: AuthStatus.error));
        }
      } catch (e) {
        print('Error during sign-in: $e');
        emit(AuthenticationState(status : AuthStatus.error , message : e.toString()));
      }
    });

    on<SignUpUser>((event, emit) async {
      //emit(const AuthenticationLoadingState(isLoading: true));
      emit(const AuthenticationState(status : AuthStatus.isLoading,));
      try {
        final UserModel? user = await authService.signUpUser(event.email, event.password);
        if (user != null) {
         // emit(SignUpSuccess(user));
          emit(AuthenticationState(status: AuthStatus.signUpSuccess, user : user ));
        } else {

         // emit(const AuthenticationError('Failed to sign up user'));
          emit(const AuthenticationState(status: AuthStatus.error, message: 'Failed to sign up user '));
        }
      } catch (e) {
        emit(AuthenticationState(status: AuthStatus.error, message : e.toString()));
        //emit(AuthenticationError(e.toString()));
      }
    });
    on<SignOut>((event, emit) async {
      emit(const AuthenticationState(status: AuthStatus.isLoading));
      //emit(const AuthenticationLoadingState(isLoading: true));  // Emit loading state
      try {
        await authService.signOutUser();
        emit(AuthenticationState(status: AuthStatus.initial));
       // emit(AuthenticationInitial());
      } catch (e) {
        //emit(AuthenticationError(e.toString()));
        emit(AuthenticationState(status: AuthStatus.error, message: e.toString()));
      }
    });
  }
}
