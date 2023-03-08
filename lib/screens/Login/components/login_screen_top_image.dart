import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          " مرحبا بك ...",
          style: TextStyle(
            fontSize: 25,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 20 * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/admin.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 20 * 2),
      ],
    );
  }
}
