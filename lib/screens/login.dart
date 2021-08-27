import 'dart:async';
import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:assignment_custom_randomiser/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Social auth sign-in.
  Future<UserCredential?> googleSignInWeb() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // googleProvider
    //     .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInHelper() async {
    UserCredential? userCredential;
    try {
      userCredential =
          (kIsWeb) ? await googleSignInWeb() : await signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    if (userCredential != null) {
      SignedInUser _signedInUser = SignedInUser();
      _signedInUser.user = userCredential.user;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            signedInUser: _signedInUser,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    child: Image.asset(
                      "assets/upes.png",
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "Assignment Custom Randomiser.",
                    style: GoogleFonts.roboto(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Auth needed for proceeding into portal <#",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextButton(
            onPressed: () async => signInHelper(),
            child: Image.asset("assets/google-signin-1x.png"),
          ),
        ],
      ),
    );
  }
}
