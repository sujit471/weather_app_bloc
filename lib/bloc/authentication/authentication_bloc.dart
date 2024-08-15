import 'package:bloc/bloc.dart';
import '../../services/authentication.dart';
import '../../services/user_model.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc({required this.authService}) : super(AuthenticationInitial()) {
    on<SigninUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));  // Emit loading state
      try {
        final UserModel? user = await authService.signInUser(event.email, event.password);
        if (user != null) {
          print('User signed in successfully');
          emit(AuthenticationSuccess(user));  // Emit success state
        } else {
          print('Failed to authenticate user');
          emit(const AuthenticationError('Failed to authenticate user'));  // Emit error state
        }
      } catch (e) {
        print('Error during sign-in: $e');
        emit(AuthenticationError(e.toString()));  // Emit error state with exception
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
