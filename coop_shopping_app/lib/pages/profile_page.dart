import 'package:coop_shopping_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const currentContext = BuildContext;

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfilePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            User? user = snapshot.data;

            return user != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name: ${user.displayName ?? "N/A"}'),
                      Text('Email: ${user.email ?? "N/A"}'),
                      ElevatedButton(
                        onPressed: () async {
                          await _handleSignOut(context);
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  )
                : const Text('Not signed in');
          },
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext? context) async {
    if (context != null) {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
                          currentContext as BuildContext,
                          MaterialPageRoute(
                              builder: ((context) => const LoginScreen())),
                          (route) => false); // Go back to the previous screen
    }
  }
}
