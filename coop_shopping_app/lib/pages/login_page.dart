import 'package:coop_shopping_app/firebase/firebase_auth_services.dart';
import 'package:coop_shopping_app/functions/signin_with_google.dart';
import 'package:coop_shopping_app/global/toast.dart';
import 'package:coop_shopping_app/pages/home_page.dart';
import 'package:coop_shopping_app/pages/signup_page.dart';
import 'package:coop_shopping_app/pallete.dart';
import 'package:coop_shopping_app/widgets/form_container_widget.dart';
import 'package:coop_shopping_app/widgets/social_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final ThemeData loginPageTheme = ThemeData.dark().copyWith();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Pallete.gradient1,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Pallete.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/images/cart.png'),
              const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SocialButton(
                iconPath: 'assets/svgs/g_logo.svg',
                label: 'Continue with Google',
                onPressed: () {
                  GoogleSignIn.signInWithGoogle(context);
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'or',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              FormContainerWidget(
                controller: _emailController,
                hintText: 'Email',
                isPasswordField: false,
              ),
              const SizedBox(
                height: 15,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: 'Password',
                isPasswordField: true,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                      Pallete.gradient3,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _signIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(285, 50),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: isSigning
                      ? const CircularProgressIndicator(
                          color: Pallete.gradient3)
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(color: Pallete.whiteColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SignupPage())),
                          (route) => false);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Pallete.gradient3,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signinWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    // Check if the widget is still mounted before updating the UI
    if (mounted) {
      if (user != null) {
        // Show success message
        showToast( "User is successfully signed in");
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomePage())));
      } else {
        showToast( "some error occured");
      }
    }
  }
}
