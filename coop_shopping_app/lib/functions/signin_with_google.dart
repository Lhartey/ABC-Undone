import 'package:flutter/material.dart';
import 'package:coop_shopping_app/global/toast.dart';
import 'package:coop_shopping_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignIn {
  static Future<void> signInWithGoogle(BuildContext context) async {
   GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebase = FirebaseAuth.instance;

    const currentContext = BuildContext;

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await firebase.signInWithCredential(credential);
        Navigator.push(
          currentContext as BuildContext,
          MaterialPageRoute(builder: (capturedContext) => const HomePage()),
        );
      }
    } catch (e) {
      showToast("Some error occurred: $e");
    }
  }
  
  signIn() {
    
  }
}