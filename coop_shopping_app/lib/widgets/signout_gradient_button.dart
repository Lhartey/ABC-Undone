import 'package:coop_shopping_app/global/toast.dart';
import 'package:coop_shopping_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:coop_shopping_app/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignoutGradientButton extends StatelessWidget {
  const SignoutGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
        showToast( "Successfully signed out");
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(170, 25),
        backgroundColor: Pallete.gradient2,
      ),
      child: const Text(
        'log Out',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
