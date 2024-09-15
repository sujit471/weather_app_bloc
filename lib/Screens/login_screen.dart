import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/Screens/signup.dart';
import 'package:weather_app_bloc/services/authentication.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../bloc/authentication/authentication_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  User? _user;
  @override
  void initState() {
    super.initState();
    printIdToken();
    _user = _auth.currentUser;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> printIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken();
      print("ID Token: $idToken");
    } else {
      print("User is not logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Email address'),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password'),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              obscureText: false,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                //if (state is AuthenticationSuccess)
                if (state.status == AuthStatus.success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  // else if ( state is AuthenticationError)
                } else if (state.status == AuthStatus.error) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(state.message ?? 'An error occurred'),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SigninUser(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      minimumSize: Size(4, 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5, // Shadow elevation
                    ),
                    child: Text(
                      // state is AuthenticationLoadingState
                      state.status == AuthStatus.isLoading
                          ? 'Logging In...'
                          : 'Login',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await AuthService.signInWithGoogle();
                  // mounted is used as it dont use the gaps between the buildcontext
                  if (user != null && mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                } on FirebaseAuthException catch (error) {
                  print(error.message);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      error.message ?? "Something went wrong ",
                    ),
                  ));
                } catch (error) {
                  print(error);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(error.toString()),
                  ));
                }
              },
              child: Text("Sign in with google"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
