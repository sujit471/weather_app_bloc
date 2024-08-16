import 'package:bloc/bloc.dart';
import '../../services/authentication.dart';
import '../../services/user_model.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;
  AuthenticationBloc({required this.authService}) : super(AuthenticationInitial()) {
    on<SigninUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signInUser(event.email, event.password);
        if (user != null) {
          print('User signed in successfully');
          emit(AuthenticationSuccess(user));
        } else {
          print('Failed to authenticate user');
          emit(const AuthenticationError('Failed to authenticate user'));
        }
      } catch (e) {
        print('Error during sign-in: $e');
        emit(AuthenticationError(e.toString()));
      }
    });

    on<SignUpUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signUpUser(event.email, event.password);
        if (user != null) {
          emit(SignUpSuccess(user));
        } else {
          emit(const AuthenticationError('Failed to sign up user'));
        }
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
    on<SignOut>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));  // Emit loading state
      try {
        await authService.signOutUser();
        emit(AuthenticationInitial());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
  }
}
