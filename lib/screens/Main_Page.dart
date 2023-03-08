import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/screens/Login/login_screen.dart';
import 'package:store_api_flutter_course/screens/home_screen.dart';

class Main_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      }),
    ));
  }
}
