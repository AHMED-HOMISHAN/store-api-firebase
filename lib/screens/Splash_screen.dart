import 'dart:async';

import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/screens/Login/login_screen.dart';
import 'package:store_api_flutter_course/screens/Main_Page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: _getlogo()),
            const SizedBox(height: 20, width: 20),
            const SizedBox(height: 20, width: 20),
            const Text('By Hanan',
                style: TextStyle(
                  color: Colors.red,
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 140, 153, 154),
    );
  }
}

Widget _getlogo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/admin.png'),
    ],
  );
}
