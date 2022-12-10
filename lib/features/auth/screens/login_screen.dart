import 'package:flutter/material.dart';
import 'package:my_reddit/core/common/sign_in_button.dart';
import 'package:my_reddit/core/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'スキップ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Dive into anything',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              Constants.loginEmotePath,
              height: 400,
            ),
          ),
          const SignInButton()
        ],
      ),
    );
  }
}
