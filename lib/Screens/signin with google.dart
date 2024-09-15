import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app_bloc/Screens/home_screen.dart';

class SignInWithGoogle extends StatefulWidget {
  SignInWithGoogle({Key? key}) : super(key: key);

  @override
  _SignInWithGoogleState createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signup(BuildContext context) async {
   try{
     final GoogleSignIn googleSignIn = GoogleSignIn();
   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
   if (googleSignInAccount != null) {
     final GoogleSignInAuthentication googleSignInAuthentication =
     await googleSignInAccount.authentication;
     final AuthCredential authCredential = GoogleAuthProvider.credential(
         idToken: googleSignInAuthentication.idToken,
         accessToken: googleSignInAuthentication.accessToken);

     // Getting users credential
     UserCredential result = await auth.signInWithCredential(authCredential);
     User? user = result.user;

     if (result != null) {
       Navigator.pushReplacement(
           context, MaterialPageRoute(builder: (context) => HomeScreen()));
     }  // if result not null we simply call the MaterialpageRoute,
     // for go to the HomePage screen
     else {
       print("Sign in cancelled by the user");

     }
   }
    }
    catch(e){
     print("Errro during sign in : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MaterialButton(
                color: Colors.teal[100],
                elevation: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                    ),
                    const SizedBox(width: 20),
                    const Text("Sign In with Google"),
                  ],
                ),
                onPressed: () {
                  signup(context);  // Call the signup method when button is pressed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
